//
//  SecondViewController.swift
//  StartingWithSirikit
//
//  Created by Bruno Cardoso Ambrosio on 17/03/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit
import IntentsUI

class SecondViewController: UIViewController {

    @IBOutlet weak var siriButtonContainer: UIView!
    private let siriButton = INUIAddVoiceShortcutButton(style: .automatic)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareSiriButton()
    }
    

    @objc func addToSiri(sender: Any) {
        guard let sender = sender as? INUIAddVoiceShortcutButton, let shortcutFromButton = sender.shortcut else { return }
        let addShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcutFromButton)
        addShortcutVC.delegate = self
        self.present(addShortcutVC, animated: true, completion: nil)
    }
    
    func prepareSiriButton() {
        
        siriButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        siriButton.translatesAutoresizingMaskIntoConstraints = false
        siriButtonContainer.addSubview(siriButton)
        
        siriButton.centerXAnchor.constraint(equalTo: siriButtonContainer.centerXAnchor).isActive = true
        siriButtonContainer.heightAnchor.constraint(equalTo: siriButton.heightAnchor).isActive = true
        
        let openSecondVC = SiriActivities.openSecondVCActivity(thumbnail: nil)
        let shortcut = INShortcut(userActivity: openSecondVC)
        siriButton.shortcut = shortcut
        siriButton.addTarget(self, action: #selector(addToSiri), for: .touchUpInside)
    }
    
    

}

extension SecondViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
