//
//  SceneDelegate.swift
//  Project7
//
//  Created by othman shahrouri on 8/15/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // AppDelegate is there to respond to system notifications such as the user exiting the app.
    


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  
        // making sure window's rootViewController is tabBarController cuz it might not be in future
        if let tabBarController = window?.rootViewController as? UITabBarController {
            
            //  To create a new ViewController,first getting a reference to our Main.storyboard file. This is done using the UIStoryboard class. You don't need to provide a bundle, because nil means "use my current app bundle.
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //  create our view controller using instantiateViewController(), passing in  storyboard ID of the view controller we want. Earlier we set our navigation controller to have the storyboard ID of "NavController", so we pass that in.
            //the code creates a duplicate ViewController wrapped inside a navigation controller
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            
            //create a UITabBarItem object for the new view controller
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            //add the new view controller to our tab bar controller's viewControllers array
            tabBarController.viewControllers?.append(vc)
            
        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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


}

