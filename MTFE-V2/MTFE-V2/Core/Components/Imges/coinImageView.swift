//
//  coinImageView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import SwiftUI

struct coinImageView: View {
    
    @StateObject var viewModel:coinImageViewModel
    init(coin:CoinModel){
        _viewModel = StateObject(wrappedValue: coinImageViewModel(coin: coin))
        
    }
    
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if viewModel.isLoading{
                ProgressView()
                
            }else{
                Image(systemName: "questionmark")
                    .foregroundColor(Color.appTheme.secondaryTextColor)
            }
        }
   
    }
}

struct coinImageView_Previews: PreviewProvider {
    static var previews: some View {
        coinImageView(coin: dev.coin)
    }
}
