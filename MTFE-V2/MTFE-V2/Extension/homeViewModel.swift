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
    
    private let dataService = MTFEDataServices()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubs()
    }
    
    func addSubs(){
        dataService.$allCoins
            .sink { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
            }
            .store(in: &cancellables)
    }
    
}
