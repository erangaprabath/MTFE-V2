//
//  homeView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

struct homeView: View {
    @EnvironmentObject private var viewModel:homeViewModel
    @State private var showPortfolio:Bool = false
    @State private var showPortfolioView:Bool = false
   
    
    var body: some View {
        ZStack{
            Color.appTheme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    portfolioView()
                        .environmentObject(viewModel)
                })
            VStack{
            homeHeader
                
                homeStatView(showPortfolio: $showPortfolio)
                
                searchBarView(searchText:$viewModel.searcText)
           
              coinSectionHeader
                
                if !showPortfolio{
                  allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    porfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            homeView()
                .navigationBarHidden(true)
        }.environmentObject(dev.homeVm)
    }
}


extension homeView{
    private var homeHeader:some View{
        HStack{
                circleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio{
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    circleButtonAnimationView(annimate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.appTheme.accent)
            Spacer()
            circleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
    private var allCoinsList:some View{
        List{
            ForEach(viewModel.allCoins) { coin in
                coinRowView(coin: coin, showHoldingColums: false )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        
    }
    
    private var porfolioCoinsList:some View{
        List{
            ForEach(viewModel.portfolioCoin) { coin in
                coinRowView(coin: coin, showHoldingColums: true )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
        
    }
    private var coinSectionHeader:some View{
        HStack{
            Text("Coins")
            Spacer()
            if showPortfolio{
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)

        }.font(.caption)
            .foregroundColor(Color.appTheme.secondaryTextColor)
            .padding(.horizontal)
    }
}
