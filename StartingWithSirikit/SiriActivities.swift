//
//  Siri.swift
//  StartingWithSirikit
//
//  Created by Bruno Cardoso Ambrosio on 17/03/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight
import MobileCoreServices

class SiriActivities {
    public static func openSecondVCActivity(thumbnail: UIImage?) -> NSUserActivity {
        let activity = NSUserActivity(activityType: "siriActivities.openSecondVC")
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier("siriActivities.openSecondVCopenSecondVC")
        
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        
        activity.title = "Open second view controller"
        
        attributes.thumbnailData = thumbnail?.jpegData(compressionQuality: 1.0)
        
        activity.suggestedInvocationPhrase = "siri test"
        activity.contentAttributeSet = attributes
        
        return activity
    }
}
