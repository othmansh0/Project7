//
//  AppDelegate.swift
//  Project7
//
//  Created by othman shahrouri on 8/15/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    //window property of app delegate,its the window of our app is running rn
    //windows have rootViewController in our case tabBarController
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

