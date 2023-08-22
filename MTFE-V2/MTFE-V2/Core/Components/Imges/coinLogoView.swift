//
//  coinLogoView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-22.
//

import SwiftUI

struct coinLogoView: View {
    let coin:CoinModel
    var body: some View {
        VStack{
             coinImageView(coin: coin)
                .frame(width: 50,height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.appTheme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.appTheme.accent)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
            
            
        }
        
    }
}

struct coinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        coinLogoView(coin: dev.coin)
    }
}
