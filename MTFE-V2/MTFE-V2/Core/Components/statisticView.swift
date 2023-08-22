//
//  statisticView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import SwiftUI

struct statisticView: View {
    
    let stat:Stastistic
    
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.appTheme.secondaryTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(Color.appTheme.accent)
            HStack{
                Image(systemName:"triangle.fill")
                    .font(.caption)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }.foregroundColor(
                (stat.percentageChange ?? 0) >= 0 ? Color.appTheme.green : Color.appTheme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
                
        }
    }
}

struct statisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            statisticView(stat: dev.stat1)
            statisticView(stat: dev.stat2)
            statisticView(stat: dev.stat3)
        }
        
        
        
    }
}
