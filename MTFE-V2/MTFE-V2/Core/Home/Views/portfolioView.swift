//
//  portfolioView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-22.
//

import SwiftUI

struct portfolioView: View {
    @EnvironmentObject private var viewModel:homeViewModel
    @State private var selectedCoin:CoinModel? = nil
    @State private var quantity:String = ""
    @State private var showCheckMark:Bool = false
   
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading,spacing:0){
                    searchBarView(searchText: $viewModel.searcText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit portfolio")
            .toolbar(content: {
                ToolbarItem(placement:.navigationBarTrailing){
                    HStack(spacing: 10.0) {
                        
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0)
                        Button {
                           saveButtonPressed()
                        } label: {
                            Text("save".uppercased())
                            
                        }.opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantity) ? 1.0 : 0 )
                    }.font(.headline)
                  
                }
            })
        }
    }
}

extension portfolioView{
    private var coinLogoList:some View{
        ScrollView(.horizontal,showsIndicators: false,content:  {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins){
                    coins in
                    coinLogoView(coin: coins)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coins
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(selectedCoin?.id == coins.id ? Color.appTheme.green : Color.clear)
                        )
                }
            }
            .padding(.vertical,4)
            .padding(.leading)
        })
    }
    
    private func getCurrentvalue() -> Double{
        if let quantity = Double(quantity){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    private var portfolioInputSection:some View{
        VStack(spacing:20){
            HStack{
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "") :")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6decimal() ?? "")
            }
            Divider()
            HStack{
                Text("You Amount ")
                Spacer()
                TextField("Ex: 1.14", text:$quantity)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            HStack{
                Text("Current Value")
                Spacer()
                Text(getCurrentvalue().asCurrencyWith2decimal())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin else { return }
        
        
        
        
        withAnimation(.easeIn){
            showCheckMark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        viewModel.searcText = ""
    }
}


struct portfolioView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            homeView()
            portfolioView()
        }
    }
}
