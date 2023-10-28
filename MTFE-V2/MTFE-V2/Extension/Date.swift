//
//  Date.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import Foundation


extension Date{
    init(coinGekoString:String)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGekoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    private var shortFomatter:DateFormatter{
        let fomatter = DateFormatter()
        fomatter.dateStyle = .short
        return fomatter
    }
    func asShortDateString() -> String{
        return shortFomatter.string(from: self)
    }
}
