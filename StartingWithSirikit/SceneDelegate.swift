//
//  SceneDelegate.swift
//  StartingWithSirikit
//
//  Created by Bruno Cardoso Ambrosio on 16/03/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // gets the userActivity if there is one and call our func 
        if let userAct = connectionOptions.userActivities.first{
            dealWithUserActivities(userActivity: userAct, isContinuing: false)
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        dealWithUserActivities(userActivity: userActivity, isContinuing: true)
    }
    
    fileprivate func openSecondVC() {
        // Loads SecondViewController from main.storyboard
        let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second") as! SecondViewController
        // Loads the Navigation Controller from main.storyboard
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navController") as! UINavigationController
        // sets the initial window to navigation controller, otherwise it would lose the navigation items (like back button)
        self.window!.rootViewController = navController
        // navigate to the secondVC
        navController.pushViewController(secondVC, animated: true)
        // turns the app visible
        self.window!.makeKeyAndVisible()
    }
    
    func dealWithUserActivities(userActivity: NSUserActivity, isContinuing: Bool) {
        switch userActivity.activityType {
        case SiriActivitiesType.openSecondVCActivity.rawValue:
                openSecondVC()
            break
        default:
            break
        }
    }

}

