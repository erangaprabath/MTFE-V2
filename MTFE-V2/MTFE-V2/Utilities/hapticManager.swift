//
//  hapticManger.swift
//  MTFE-V2
//
//  Created by Eranga prabath on 2023-08-24.
//

import Foundation
import SwiftUI

class hapticManager{
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        generator.notificationOccurred(type)
    }
}
