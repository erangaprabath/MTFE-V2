//
//  DetailsView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import SwiftUI


struct detsilsLoadinView:View{
    @Binding var coin:CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin{
               DetailsView(coin: coin)
            }
        }
       
    }
}


struct DetailsView: View {
    
    @StateObject private var viewModel:DetaliViewModel
    private let column:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())

    ]
    private let spacing:CGFloat = 30
    
    init(coin:CoinModel){
     
    _viewModel = StateObject(wrappedValue:DetaliViewModel(coin: coin))

        print("initializing Details view for \(coin.name)")
    }
    
    var body: some View {
        ScrollView{
            VStack{
                charView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(spacing: 20.0){
                   
                    overViewTitel
                    Divider()
                    overViewGridView
                    additionalTitel
                    Divider()
                    additionalGridView
                }
                .padding()
            }
          
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTralingItems
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailsView(coin: dev.coin)
        }
    }
}

extension DetailsView{
    
    private var navigationBarTralingItems:some View{
        HStack{
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.appTheme.secondaryTextColor)
        coinImageView(coin: viewModel.coin)
                .frame(width: 25,height: 25)
        }
    
    }
    private var overViewTitel:some View{
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundColor(Color.appTheme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    private var additionalTitel:some View{
        Text("Additional View")
            .font(.title)
            .bold()
            .foregroundColor(Color.appTheme.accent)
            .frame(maxWidth: .infinity, alignment:.leading)
    }
    private var additionalGridView:some View{
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content:{
                ForEach(viewModel.additionalStatistics){ stat
                    in statisticView(stat: stat)
                }

            })

    }
    private var overViewGridView:some View{
        LazyVGrid(
            columns: column,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content:{
                ForEach(viewModel.overViewStatistics){ stat
                    in statisticView(stat: stat)
                }

            })

    }
}
