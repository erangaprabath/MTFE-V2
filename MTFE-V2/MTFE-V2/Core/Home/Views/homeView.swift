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
    @State private var selectedCoin:CoinModel? = nil
    @State private var showDetailsView:Bool = false
    @State private var settings:Bool = false
    let maxWidthForIpad:CGFloat = 400
 
   
    
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
                
                searchBarView(searchText:$viewModel.searchText)
           
              coinSectionHeader
                
                if !showPortfolio{
                  allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio{
                    ZStack(alignment:.bottomTrailing){
                        if viewModel.portfolioCoin.isEmpty && viewModel.searchText.isEmpty{
                            withAnimation(.spring()){
                                showHints
                                
                                  
                                
                            }
                        }
                        else{
                            porfolioCoinsList
                        }
                        
                    }.frame(maxHeight: .infinity)
                       
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }.sheet(isPresented: $settings) {
                SettingsView()
            }
        }.background(
            NavigationLink(
                destination: detsilsLoadinView(coin: $selectedCoin) ,
                isActive: $showDetailsView,
                label: {
                    EmptyView()
                })
        )
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
                    }else{
                        settings.toggle()
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
                    .onTapGesture {
                    segue(coin: coin)
                    }
                
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.reloadData()
            
        }
        
    }
    private func segue(coin:CoinModel){
        selectedCoin = coin
        showDetailsView.toggle()
    }
    
    private var porfolioCoinsList:some View{
        List{
            ForEach(viewModel.portfolioCoin) { coin in
                coinRowView(coin: coin, showHoldingColums: true )
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
       
        
    }
    private var coinSectionHeader:some View{
        HStack{
            HStack(spacing: 4.0){
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankedReversed ) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }.onTapGesture {
                withAnimation(.default){
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankedReversed : .rank
                }
            }
            Spacer()
            if showPortfolio{
                HStack(spacing: 4.0){
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingReversed) ? 1.0 : 0 )
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }.onTapGesture {
                    withAnimation(.default){
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingReversed : .holdings
                    }
                }
                
            }
            HStack(spacing: 4.0){
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0 )
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            } .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default){
                        viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                    }
                }

            
           

        }.font(.caption)
            .foregroundColor(Color.appTheme.secondaryTextColor)
            .padding(.horizontal)
    }
    private var showHints:some View{
        ZStack{
            Color.appTheme.red
            Text("Click The + Icon To Buy Coins 🙂".uppercased())
                .foregroundColor(Color.appTheme.accent)
                .font(.headline)
                .multilineTextAlignment(.center)
             
            
        }.frame(maxWidth: maxWidthForIpad)
            .frame(maxWidth: maxWidthForIpad)
            .frame(height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(50)
    }
}
