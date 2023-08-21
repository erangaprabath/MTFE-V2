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
    @Published var statistic:[Stastistic] = [
        Stastistic(title: "Titel", value: "Value",percentageChange: 1),
        Stastistic(title: "Titel", value: "Value"),
        Stastistic(title: "Titel", value: "Value"),
        Stastistic(title: "Titel", value: "Value",percentageChange: -7)
    ]

    
    private let dataService = MTFEDataServices()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubs()
    }
    
    func addSubs(){
    // upadate all coins
        $searcText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (retunCoins) in
                self?.allCoins = retunCoins
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
    
}
