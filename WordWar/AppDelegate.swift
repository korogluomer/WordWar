//
//  AppDelegate.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 30.04.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ref:DatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        if Auth.auth().currentUser != nil{
            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("status").setValue("online")
            
            UserBilgiler.bilgileriAl()
            
            let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
            let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
            window!.rootViewController = protectedPage
            window!.makeKeyAndVisible()
            
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if Auth.auth().currentUser != nil{
            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("status").setValue("offline")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if Auth.auth().currentUser != nil{
            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("status").setValue("online")
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

