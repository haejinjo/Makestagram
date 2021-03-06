//
//  AppDelegate.swift
//  Makestagram
//
//  Created by Haejin Jo on 7/4/17.
//  Copyright © 2017 Haejin Jo. All rights reserved.
//

import UIKit
import Firebase


// App Delegate is a singleton object handling important events in life cycle of our app
    // including:
    // -executing app's startup code
    // -handling app lifecycle events like tranasitioning to the background or termination
    // -receiving push notifications or deep linking
// A singleton is like a global var in that it enables easy access to shared resource
// Used widely in iOS but careful to create your own because usually a sign of bad code architecture
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    
    var window: UIWindow?

    
    //Performed at launch time, can be used for addt'l setup b4 app has launched
        // Changed app window's root view controller
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
    
        ConfigureInitialRootViewController(for: window)
        
//        //If login storyboard has initial VC set
//        let initialViewController = UIStoryboard.initialViewController(for: .login)
//            //Set to window's rootViewController property
//            window?.rootViewController = initialViewController
//            
//            //and position the window above any other existing windows
//            window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// Determine which storyboard's initial view controller should be set as the root view controller of the window!
    // If the FIRUser singleton already exists and we unarchive data for the currentUser key from UserDefaults,
        // we'll know the user has been previously authenticated on this device 
    // Then, we can skip login flow
extension AppDelegate {
    func ConfigureInitialRootViewController(for window: UIWindow?) {
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if Auth.auth().currentUser != nil,
        let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
        let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            User.setCurrent(user)
            
            initialViewController = UIStoryboard.initialViewController(for: .main)
        }
        else {
            
            initialViewController = UIStoryboard.initialViewController(for: .login)
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
        
    }
}

