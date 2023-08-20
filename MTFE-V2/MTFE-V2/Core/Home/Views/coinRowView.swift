//
//  coinRowView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-20.
//

import SwiftUI



struct coinRowView: View {
    let coin:CoinModel
    let showHoldingColums:Bool
    var body: some View {
        HStack(spacing:0){
            leftColumn
            Spacer()
            if showHoldingColums{
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

struct coinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            coinRowView(coin: dev.coin,showHoldingColums: true)
            coinRowView(coin: dev.coin,showHoldingColums: true)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
extension coinRowView{
    private var leftColumn:some View{
        HStack(spacing:0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.appTheme.secondaryTextColor)
                .frame(minWidth: 30)
         
       coinImageView(coin: coin)
                .frame(width: 30,height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundColor(Color.appTheme.accent)
        }
    }
    private var centerColumn:some View{
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2decimal())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundColor(Color.appTheme.accent)
    }
    
    private var rightColumn:some View{
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6decimal())
                .bold()
                .foregroundColor(Color.appTheme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0 >= 0 ?
                    Color.appTheme.green :
                    Color.appTheme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width/3.5,alignment: .trailing)
    }
}
