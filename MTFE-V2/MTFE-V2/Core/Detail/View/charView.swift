//
//  charView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import SwiftUI
import Charts

struct charView: View {
    
    private let data:[Double]
    private let maxY:Double
    private let minY:Double
    private let lineColor:Color
    private let startingdate:Date
    private let endingdate:Date
    @State private var percentage:CGFloat = 0
    
    init(coin:CoinModel)
    {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.appTheme.green : Color.appTheme.red
        endingdate = Date(coinGekoString: coin.lastUpdated ?? "")
        startingdate = endingdate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(charAxis.padding(4),alignment: .leading)
            chartDates
                .padding(4)
        }.font(.caption)
            .foregroundColor(Color.appTheme.secondaryTextColor)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    withAnimation(.linear(duration:2.0)){
                        percentage = 1.0
                        
                    }
                }
            }
       
    }
}

struct charView_Previews: PreviewProvider {
    static var previews: some View {
        charView(coin: dev.coin)
        
    }
}

extension charView{
    private var chartView:some View{
        GeometryReader { geomety in
            Path{ path in
                for index in data.indices{
                    
                    let xPosition = geomety.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let YAxis = maxY - minY
                    
                    let yPosition = (1-CGFloat((data[index] - minY) / YAxis)) * geomety.size.height
                    
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
            }
            .trim(from: 0,to: percentage)
            .stroke(lineColor,style: StrokeStyle(lineWidth: 2,lineCap: .round,lineJoin: .round))
            .shadow(color: lineColor, radius: 10,x:0,y:10)
            .shadow(color: lineColor.opacity(0.4), radius: 10,x:0,y:20)
            .shadow(color: lineColor.opacity(0.2), radius: 10,x:0,y:30)
            .shadow(color: lineColor.opacity(0.1), radius: 10,x:0,y:40)
        }
        
    }
    private var chartBackground:some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
            
        }
    }
    private var charAxis:some View{
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            let price = (maxY - minY / 2).formattedWithAbbreviations()
            Text(price)
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    private var chartDates:some View{
        HStack{
            Text(startingdate.asShortDateString())
            Spacer()
            Text(endingdate.asShortDateString())
        }
    }

}
