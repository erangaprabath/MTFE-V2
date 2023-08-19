//
//  homeView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

struct homeView: View {
    @State private var showPortfolio:Bool = false
    var body: some View {
        ZStack{
            Color.appTheme.background
                .ignoresSafeArea()
            VStack{
            homeHeader
                Spacer(minLength: 0)
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            homeView()
                .navigationBarHidden(true)
        }
    }
}


extension homeView{
    private var homeHeader:some View{
        HStack{
                circleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
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
}
