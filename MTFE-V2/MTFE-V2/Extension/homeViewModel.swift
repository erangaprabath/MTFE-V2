//
//  homeViewModel.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import Combine


class homeViewModel:ObservableObject{
    @Published var allCoins:[CoinModel] = []
    @Published var portfolioCoin:[CoinModel] = []
    @Published var searchText:String = ""
    @Published var statistic:[Stastistic] = []
    @Published var isloading:Bool = false
    @Published var sortOption:sortingTypes = .holdings

    
    private let coinDataService = MTFEDataServices()
    private let MarketDataService = marketDataService()
    private let portfolioDatService = portfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    enum sortingTypes{
        
        case rank, rankedReversed,holdings,holdingReversed,price,priceReversed
    }
    
    
    init(){
        addSubs()
    }
    
    func addSubs(){
        // upadate all coins
        $searchText
            .combineLatest(coinDataService.$allCoins,$sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (retunCoins) in
                self?.allCoins = retunCoins
            }
            .store(in: &cancellables)
        
        $allCoins
            .combineLatest(portfolioDatService.$saveEntities)
            .map(mapAllCoinsTOPortfolioCoins)
            .sink { [weak self] (returnedCoin) in
                guard let self = self else{ return }
                self.portfolioCoin = self.sortPortfolioIfNeeded(coins: returnedCoin)
            }.store(in: &cancellables)
        
        MarketDataService.$marketData
            .combineLatest($portfolioCoin)
            .map(mapGlobalMarketCap)
            .sink { [weak self] (returnStats) in
                self?.statistic = returnStats
                self?.isloading = false
            }
            .store(in: &cancellables)
        
    }
    
    func updatePortfolio(coin:CoinModel,amount:Double){
        portfolioDatService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData(){
        isloading = true
        coinDataService.getCoins()
        MarketDataService.getdata()
        hapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text:String,coin:[CoinModel],sort:sortingTypes) -> [CoinModel]{
        var updatedCoins = filterCoins(text: text, coins: coin)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
        
    }
    
    private func filterCoins(text:String,coins:[CoinModel]) -> [CoinModel]{
        
        guard !text.isEmpty else{
            return coins
        }
        let lowecasedText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowecasedText) ||
            coin.symbol.lowercased().contains(lowecasedText) ||
            coin.id.lowercased().contains(lowecasedText)
            
        }
    }

    private func sortCoins(sort:sortingTypes,coins: inout [CoinModel]) {
        switch sort {
        case.rank,.holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankedReversed,.holdingReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
           coins.sort(by: {$0.currentPrice < $1.currentPrice})
     
            
        }
    }
    private func sortPortfolioIfNeeded(coins:[CoinModel]) -> [CoinModel]{
        switch sortOption{
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
    }
    private func mapAllCoinsTOPortfolioCoins(allCoins:[CoinModel],portfolioEntities:[PortfolioEntity]) -> [CoinModel]{
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id })
                else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }

    }
    private func mapGlobalMarketCap(MarketDataModel:MarketDataModel?,porfolioCoins:[CoinModel]) ->[Stastistic]{
        
        var stats: [Stastistic] = []
        
        guard let data = MarketDataModel else {
            return stats
            
        }
        
        let marketCap = Stastistic(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Stastistic(title: "24H Volume", value: data.volume)
        let btcDominance = Stastistic(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue = porfolioCoins.map({$0.currentHoldingsValue})
            .reduce(0 , +)
        
        let previousValue =
        porfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let precentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previosValue = currentValue / (1 + precentChange)
                return previosValue
            }
            .reduce(0 , +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portfolio = Stastistic(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2decimal() ,percentageChange: percentageChange)
        
     
        
         
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        
        return stats
        
        
    }
}
