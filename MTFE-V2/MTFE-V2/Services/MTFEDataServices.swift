//
//  MTFEDataServices.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import Combine

class MTFEDataServices {
    
    @Published var allCoins: [CoinModel] = []
    var coinsSubscription:AnyCancellable?
    
    init(){
        
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else{ return }
        
        coinsSubscription = networkingManger.donwload(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManger.handelCompletion,receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinsSubscription?.cancel()
            })

    }
    
}
