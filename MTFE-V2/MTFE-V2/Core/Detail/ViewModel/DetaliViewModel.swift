//
//  DetaliViewModel.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import Foundation
import Combine
 

class DetaliViewModel:ObservableObject{
    @Published var overViewStatistics:[Stastistic] = []
    @Published var additionalStatistics:[Stastistic] = []
    @Published var discription:String? = nil
    @Published var websiteURL:String? = nil
    @Published var reditURL:String? = nil

    @Published var coin:CoinModel
    private let coinDetailsService:coinDetailsDataService
    private var cancellable = Set<AnyCancellable>()
    
  
  

    
    init(coin:CoinModel){
        self.coin = coin
        self.coinDetailsService = coinDetailsDataService(coin: coin)
        self.addSubs()
    }
    
    private func addSubs(){
        coinDetailsService.$coinDetalis
            .combineLatest($coin)
            .map(mapAdditionalAndOverViewDetails)
            .sink {[weak self] (returnCoinDetail) in
                self?.overViewStatistics = returnCoinDetail.overvew
                self?.additionalStatistics = returnCoinDetail.additional
            }
            .store(in: &cancellable)
        coinDetailsService.$coinDetalis
            .sink { [weak self](returncoinDetails) in
                self?.discription = returncoinDetails?.readableDescription
                self?.websiteURL = returncoinDetails?.links?.homepage?.first
                self?.reditURL = returncoinDetails?.links?.subredditURL
            }
            .store(in: &cancellable)
    }
    
    private func mapAdditionalAndOverViewDetails(CoinDetailModel:CoinDetailModel?,coinModel:CoinModel) -> (overvew:[Stastistic],additional:[Stastistic]){
     let overViewArray = overViewArray(coinModel: coinModel)
        let additionalArray = additionalArray(CoinDetailModel: CoinDetailModel, coinModel: coinModel)
         return(overViewArray,additionalArray)
    }
    
    private func overViewArray(coinModel:CoinModel) -> [Stastistic]{
        
        let price = coinModel.currentPrice.asCurrencyWith6decimal()
        let priceChnage = coinModel.priceChangePercentage24H
        let priceStat = Stastistic(title: "Current Price", value: price,percentageChange: priceChnage)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapPrecentachangeStat = Stastistic(title: "market Capitalization", value: marketCap,percentageChange: marketCapPercentChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = Stastistic(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Stastistic(title: "Volume", value: volume)
        let overViewArray:[Stastistic] = [priceStat,marketCapPrecentachangeStat,rankStat,volumeStat]
        
        return overViewArray
        
    }
    
    private  func additionalArray(CoinDetailModel:CoinDetailModel?,coinModel:CoinModel) -> [Stastistic]{
        let high = coinModel.high24H?.asCurrencyWith6decimal() ?? "n/a"
        let highStat = Stastistic(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6decimal() ?? "n/a"
        let lowStat = Stastistic(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6decimal() ?? "n/a"
        let pricePercentage2 = coinModel.priceChangePercentage24H
        let priceChangeStat = Stastistic(title: "24H Low", value: priceChange,percentageChange: pricePercentage2)
        
        let marketCapChange = "$" + (coinModel.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "")
        let marketCapchange2 = coinModel.marketCapChangePercentage24H
        let marketChangeStat = Stastistic(title: "24H Market Cap Change", value: marketCapChange,percentageChange: marketCapchange2)
        
        let blockTime = CoinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = Stastistic (title: "Block Time", value: blockTimeString)
        
        let hashing = CoinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = Stastistic(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray:[Stastistic] = [highStat,lowStat,priceChangeStat,marketChangeStat,blockTimeStat,hashingStat]
        
        return additionalArray
    }
}
