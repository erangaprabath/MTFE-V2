//
//  HTMLremover.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-25.
//

import Foundation

extension String{
    
    var removingHTMLOccurances:String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "",options:.regularExpression,range: nil)
    }
}
