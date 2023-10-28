//
//  CoinDetailsDataService.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import Foundation
import Combine

class coinDetailsDataService {
    
    @Published var coinDetalis:CoinDetailModel? = nil
    
    var coinsDetailsSubscription:AnyCancellable?
    let coin:CoinModel
    
    init(coin:CoinModel){
        self.coin = coin
        
        getCoinsDetails()
    }
    
    func getCoinsDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else{ return }
        
        coinsDetailsSubscription = networkingManger.donwload(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkingManger.handelCompletion,receiveValue: { [weak self] (returnCoinsdetails) in
                self?.coinDetalis = returnCoinsdetails
                self?.coinsDetailsSubscription?.cancel()
            })

    }
    
}
