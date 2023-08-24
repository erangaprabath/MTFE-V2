//
//  marketDataService.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import SwiftUI
import Combine

class marketDataService{
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription:AnyCancellable?
    
    init(){
        
        getdata()
    }
    
  func getdata(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else{ return }
        
      marketDataSubscription = networkingManger.donwload(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManger.handelCompletion,receiveValue: { [weak self] (returnGlobalData) in
                self?.marketData = returnGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
        
    }
}
 
