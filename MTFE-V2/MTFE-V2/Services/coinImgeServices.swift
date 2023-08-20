//
//  coinImgeServices.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import SwiftUI
import Combine

class coinImageServices{
    
    @Published var image:UIImage? = nil
    var imageSubscription:AnyCancellable?
    private var coin:CoinModel
    
    init(coin:CoinModel){
    
        self.coin = coin
        getImageData()
    }
    
    private func getImageData(){
        guard let url = URL(string: coin.image)
        else{ return }
        
      imageSubscription = networkingManger.donwload(url: url)
            .tryMap({(data) -> UIImage? in
                return UIImage(data: data)
            })

            .sink(receiveCompletion: networkingManger.handelCompletion,receiveValue: { [weak self] (returnCoins) in
                self?.image = returnCoins
                self?.imageSubscription?.cancel()
            })

        
    }
}
