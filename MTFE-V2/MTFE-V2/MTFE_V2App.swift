//
//  MTFE_V2App.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

@main
struct MTFE_V2App: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                homeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
