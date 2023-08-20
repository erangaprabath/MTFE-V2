//
//  MTFE_V2App.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

@main
struct MTFE_V2App: App {
    @StateObject private var viewModel = homeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                homeView()
                    .navigationBarHidden(true)
            }.environmentObject(viewModel)
        }
    }
}
