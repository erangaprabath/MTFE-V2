//
//  statisticModel.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import Foundation

struct Stastistic:Identifiable{
    let id = UUID().uuidString
    let title:String
    let value:String
    let percentageChange:Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

