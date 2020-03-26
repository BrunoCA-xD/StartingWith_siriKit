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
        
        SiriUtil.openShortcutViewController(caller: self, shortcut: shortcutFromButton) { (shortcutViewController) in
//            as we are on a closure, we need to call the main thread to present the modal
            DispatchQueue.main.async {
                self.present(shortcutViewController, animated: true, completion: nil)
            }
        }
    }
    
    func prepareSiriButton() {
        
        //set the horizontal content hugging to 250 (defaultLow)
        siriButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        //Turn off the autolayout constraints because we gonna do by our own
        siriButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Add the button to the container
        siriButtonContainer.addSubview(siriButton)
        
        //Centralize the button in X axis in the container
        siriButton.centerXAnchor.constraint(equalTo: siriButtonContainer.centerXAnchor).isActive = true
        
        //Bind the both heights
        siriButtonContainer.heightAnchor.constraint(equalTo: siriButton.heightAnchor).isActive = true

        //TODO: add shortcut to the button
        
        //set the callback of the button
        siriButton.addTarget(self, action: #selector(addToSiri), for: .touchUpInside)
    }
    
    

}

extension SecondViewController: INUIAddVoiceShortcutViewControllerDelegate {
    // when the add action is completed
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    // when the add action is canceled
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SecondViewController: INUIEditVoiceShortcutViewControllerDelegate{
    
    //When the edit option is to update the shortcut
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    //When the edit option is to delete the shortcut
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //When modal Cancel button is tapped
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
