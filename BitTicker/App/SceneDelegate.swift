//
//  SceneDelegate.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // get login status from user default
        let status = UserDefaults.standard.bool(forKey: AppConstants.IS_LOCKED_IN_KEY)
        
        // root vc
         var rootVC : UIViewController?
                 
        // check the status of login and navigate accordingly
         if(status == true){
            // if user login already then set rootvc as landing vc
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstants.LANDING_VC_IDENTIFIER) as! LandingVC
         }else{
            // if user not login then set rootvc as login vc
             rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: AppConstants.LOGIN_VC_IDENTIFIER) as! LoginVC
         }
         
        // set initial root view controller
         window?.rootViewController = rootVC
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

        // Save changes in the application's managed object context when the application transitions to the background.
        
    }


}
