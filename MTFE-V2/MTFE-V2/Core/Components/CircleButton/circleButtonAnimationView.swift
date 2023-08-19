//
//  circleButtonAnimationView.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-19.
//

import SwiftUI

struct circleButtonAnimationView: View {
    @Binding var annimate:Bool
    var body: some View {
       Circle()
            .stroke(lineWidth: 5.0)
            .scale(annimate ? 1.0 : 0.0)
            .opacity(annimate ? 0.0 : 1.0)
            .animation(annimate ? Animation.easeOut(duration: 1.0) : .none)
           
    }
}

struct circleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        circleButtonAnimationView(annimate: .constant(false))
    }
}
