//
//  splashScreen.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-26.
//

import SwiftUI

struct splashScreen: View {
    @State private var textAnimation:Bool = false
    @Binding var shwoMainMenu:Bool
    @State private var textAnimationString:[String] = "Loading MTFE portfolio...".map{ String($0) }
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State private var counter:Int = 0
    @State private var loops:Int = 0
    var body: some View {
        ZStack{
            Color.appTheme.background
                .ignoresSafeArea()
        
                Image("1671692610539")
                    .resizable()
                    .frame(width: 100,height: 100)
                    
            ZStack{
                
                if textAnimation{
    
                    HStack(spacing: 0.0){
                        ForEach(textAnimationString.indices){ index in
                            Text(textAnimationString[index].uppercased())
                                .foregroundColor(Color.appTheme.accent)
                                .font(.caption2)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
                
            } .offset(y:80)
            
        }
            .onAppear{
                textAnimation.toggle()
            }
            .onReceive(timer) { _ in
                withAnimation(.spring()){
                    let lastIndex = textAnimationString.count-1
                    if counter == lastIndex{
                        counter = 0
                        loops += 1
                    if loops >= 4{
                            shwoMainMenu.toggle()
                            
                        }
                    }else{
                        counter += 1
                    }
                }
            }
           
    }
}

struct splashScreen_Previews: PreviewProvider {
    static var previews: some View {
        splashScreen(shwoMainMenu: .constant(true))
    }
}
