//
//  coinImageViewModel.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import Foundation
import SwiftUI
import Combine


class coinImageViewModel:ObservableObject{
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    private var coin:CoinModel
    private var dataService:coinImageServices
    private var cancellable = Set<AnyCancellable>()
    
    
    init(coin:CoinModel){
        self.coin = coin
        self.dataService = coinImageServices(coin: coin)
        self.addImageSubs()
        self.isLoading = true
    }
    
    
    private func addImageSubs(){
        
        dataService.$image
            .sink { [weak self](_) in
                self?.isLoading = false
            } receiveValue: { [weak self]  (returningImage)in
                self?.image = returningImage
            }
            .store(in: &cancellable)

    }
    
}
