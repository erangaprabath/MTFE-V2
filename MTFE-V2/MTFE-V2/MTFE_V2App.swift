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
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.appTheme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.appTheme.accent)]

    }
    var body: some Scene {
        WindowGroup {
            NavigationView{
                homeView()
                    .navigationBarHidden(true)
            }.environmentObject(viewModel)
        }
    }
}
