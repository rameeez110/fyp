//
//  AppDelegate.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        DataBaseUtility.sharedInstance.copyDatabaseIntoDocumentsDirectory()
        
        instanitateViewController()
        
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
    
    func instanitateViewController(){
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
//        let isLoggedIn = checkWhichTypeUserIsLoggedIn()
        
        let rootNavigationController = UINavigationController()
        let fullTimeTableMorningViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTableMorning") as! FullTimeTableMorningViewController
        fullTimeTableMorningViewController.timeTableMutableArray = NSMutableArray()
        self.window!.rootViewController = rootNavigationController
//        fullTimeTableMorningViewController.timeTableMutableArray = array
//        self.navigationController!.pushViewController(fullTimeTableMorningViewController, animated:true)
        rootNavigationController.pushViewController(fullTimeTableMorningViewController, animated: true)
        
        /*if isLoggedIn == "NOT LOGGED IN"
        {
            let rootNavigationController = UINavigationController()
            rootNavigationController.navigationBar.barTintColor = UIColor(red: 0/255, green: 25/255, blue: 43/255, alpha: 1)
            self.window!.rootViewController = rootNavigationController
            let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as! ViewController
            rootNavigationController.pushViewController(signInViewController, animated: true)
        }
        else if isLoggedIn == "ADMIN"
        {
            let rootNavigationController = UINavigationController()
            rootNavigationController.navigationBar.barTintColor = UIColor(red: 0/255, green: 25/255, blue: 43/255, alpha: 1)
            self.window!.rootViewController = rootNavigationController
            let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adminMainView") as! MainViewController
            rootNavigationController.pushViewController(mainViewController, animated: true)
        }
        else if isLoggedIn == "TEACHER"
        {
            let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TeacherTabBarController") as! UITabBarController
            self.window!.rootViewController = tabBarController
        }
        else if isLoggedIn == "STUDENT"
        {
            let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "StudentTabBarController") as! UITabBarController
            self.window!.rootViewController = tabBarController
        }*/
        
        self.window?.makeKeyAndVisible()
    }
    
    func checkWhichTypeUserIsLoggedIn() -> String
    {
        var user = "NOT LOGGED IN"
        
        // Admin User
        
        let loggedInUserType = UserDefaults.standard.string(forKey: "LoggedInUserType")
        
        if (loggedInUserType != nil) {
            user = loggedInUserType!
        }
        
//        return user
        return "ADMIN"
    }

}

