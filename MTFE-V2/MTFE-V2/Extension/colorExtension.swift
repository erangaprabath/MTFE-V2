//
//  colorExtension.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import Foundation
import SwiftUI

extension Color{
    static let appTheme = colorTheme()
}

struct colorTheme{
    let accent = Color("AccentColor")
    let background = Color("backgroundColor")
    let green = Color("greenColor")
    let red  = Color("redColor")
    let secondaryTextColor = Color("secondaryTextColor")
    
}
