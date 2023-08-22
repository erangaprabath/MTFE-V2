//
//  uiApplication.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import SwiftUI

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
