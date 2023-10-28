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
    @State private var showMainMenu:Bool = true
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.appTheme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.appTheme.accent)]

    }
    var body: some Scene {
        WindowGroup {
            ZStack{
            NavigationView{
                
                homeView()
                    .navigationBarHidden(true)
         
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(viewModel)
           
            ZStack{
                if showMainMenu{
                    splashScreen(shwoMainMenu: $showMainMenu)
                        .transition(.move(edge: .leading))
                  
                }
            }

               
            }
         
        }
    }
}
