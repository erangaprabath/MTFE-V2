//
//  circleButtonView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

struct circleButtonView: View {
    
    let iconName:String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.appTheme.accent)
            .frame(width: 50,height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.appTheme.background)
            ).shadow(
                color: Color.appTheme.accent.opacity(0.25),
                radius: 10,
                x:0,
                y: 0
            ).padding()
 
    }
}

struct circleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            circleButtonView(iconName: "info")
       
                .previewLayout(.sizeThatFits)
            circleButtonView(iconName: "plus")
            
                .previewLayout(.sizeThatFits)
        }
    }
}
