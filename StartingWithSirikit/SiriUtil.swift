//
//  SiriUtil.swift
//  StartingWithSirikit
//
//  Created by Bruno Cardoso Ambrosio on 19/03/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import IntentsUI

class SiriUtil {
    
   private static func recoverVoiceShortcut(whenMatchWith shortcut: INShortcut,  completion: @escaping (INVoiceShortcut?) -> () ) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voicesShortcuts, error) in
            if error != nil {
                return
            }
            let voiceShortcut = voicesShortcuts?.first(where: { (voiceShort) -> Bool in
                return voiceShort.shortcut.userActivity?.activityType == shortcut.userActivity?.activityType
            })
            completion(voiceShortcut)
        }
    }
    
   static func openShortcutViewController(caller: UIViewController, shortcut: INShortcut, open: @escaping (UIViewController) -> Void ) {
        var addShortcutVC: INUIAddVoiceShortcutViewController?
        var editShortcutVC: INUIEditVoiceShortcutViewController?
        
        self.recoverVoiceShortcut(whenMatchWith: shortcut) { (voiceShortcut) in
        
            if voiceShortcut == nil {
                addShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
                addShortcutVC?.delegate = (caller as! INUIAddVoiceShortcutViewControllerDelegate)
                open(addShortcutVC!)
            } else {
                editShortcutVC = INUIEditVoiceShortcutViewController(voiceShortcut: voiceShortcut!)
                editShortcutVC?.delegate = (caller as! INUIEditVoiceShortcutViewControllerDelegate)
                open(editShortcutVC!)
            }
            
        }
    }
}
