//
//  homeStatView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-21.
//

import SwiftUI

struct homeStatView: View {
    @EnvironmentObject private var viewModel: homeViewModel 
    @Binding var showPortfolio:Bool
    var body: some View {
        HStack{
            ForEach(viewModel.statistic) { stat in
                statisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }.frame(width: UIScreen.main.bounds.width,
                alignment: showPortfolio ? .trailing : .leading)
    }
}

struct homeStatView_Previews: PreviewProvider {
    static var previews: some View {
        homeStatView(showPortfolio: .constant( false))
            .environmentObject(dev.homeVm)
    }
}
