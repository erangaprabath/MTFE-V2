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
    @State private var showMoreDetails:Bool =  false
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
                    descriptionView
                    overViewGridView
                    additionalTitel
                    Divider()
                    additionalGridView
                    websiteView
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
        Text("Overview")
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
    private var descriptionView:some View{
        ZStack{
            if let coinDescription = viewModel.discription,!coinDescription.isEmpty{
                
                VStack(alignment: .leading){
                    Text(coinDescription)
                        .font(.callout)
                        .foregroundColor(Color.appTheme.secondaryTextColor)
                        .lineLimit(showMoreDetails ? nil : 3)
                    Button (action:{
                        withAnimation(.easeInOut){
                            showMoreDetails.toggle()
                        }
                    }, label: {
                        Text(showMoreDetails ? "Less" : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical,4)
                    })
                    .accentColor(.blue)

                }
                .frame(maxWidth:.infinity)
                .frame(alignment: .leading)
            }
                
        }
        
    }
    private var websiteView:some View{
        VStack(alignment: .leading, spacing: 10.0){
            if let website = viewModel.websiteURL,
               let url = URL(string: website){
                Link("Website",destination: url)
            }
            
            if let reditwebsite = viewModel.reditURL,
               let url = URL(string: reditwebsite){
                Link("Redit",destination: url)
            }
            
            
        }.accentColor(.blue)
            .frame(maxWidth: .infinity,alignment:.leading)
    }
}
