//
//  coin.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import Foundation
import SwiftUI

struct CoinModel: Identifiable,Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice:Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHolding:Double?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "currentPrice"
        case marketCap = "marketCap"
        case marketCapRank = "marketCapRank"
        case fullyDilutedValuation = "fullyDilutedValuation"
        case totalVolume = "totalVolume"
        case high24H = "high24H"
        case low24H = "low24H"
        case priceChange24H = "priceChange24H"
        case priceChangePercentage24H = "priceChangePercentage24H"
        case marketCapChange24H = "marketCapChange24H"
        case marketCapChangePercentage24H = "marketCapChangePercentage24H"
        case circulatingSupply = "circulatingSupply"
        case totalSupply = "totalSupply"
        case maxSupply = "maxSupply"
        case ath = "ath"
        case athChangePercentage = "athChangePercentage"
        case athDate = "athDate"
        case atl = "atl"
        case atlChangePercentage = "atlChangePercentage"
        case atlDate = "atlDate"
        case lastUpdated = "lastUpdated"
        case sparklineIn7D = "sparklineIn7D"
        case priceChangePercentage24HInCurrency = "priceChangePercentage24HInCurrency"
        case currentHolding = "currentHolding"
    }
}

struct SparklineIn7D: Codable {
        let price: [Double]?
    }


 
