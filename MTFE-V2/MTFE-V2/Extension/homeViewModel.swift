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
    @Published var searcText:String = ""
    @Published var statistic:[Stastistic] = []

    
    private let coinDataService = MTFEDataServices()
    private let MarketDataService = marketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubs()
    }
    
    func addSubs(){
    // upadate all coins
        $searcText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (retunCoins) in
                self?.allCoins = retunCoins
            }
            .store(in: &cancellables)
        MarketDataService.$marketData
            .map(mapGlobalMarketCap)
            .sink { [weak self] (returnStats) in
                self?.statistic = returnStats
            }
            .store(in: &cancellables)
            
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
    
    private func mapGlobalMarketCap(MarketDataModel:MarketDataModel?) ->[Stastistic]{
        
        var stats: [Stastistic] = []
        
        guard let data = MarketDataModel else {
            return stats
            
        }
        
        let marketCap = Stastistic(title: "Market Cap", value: data.marketCap,percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Stastistic(title: "24H Volume", value: data.volume)
        let btcDominance = Stastistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Stastistic(title: "Portfolio Value", value: "$0.00" ,percentageChange: 0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        
        return stats
        
        
    }
}
