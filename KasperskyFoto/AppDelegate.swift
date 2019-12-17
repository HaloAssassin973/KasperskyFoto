//
//  AppDelegate.swift
//  KasperskyFoto
//
//  Created by Игорь Силаев on 28/11/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = try! Reachability()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UserDefaults.standard.register(defaults: ["cache" : [""]])
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        do {
          try reachability.startNotifier()
        } catch {
          print("could not start reachability notifier")
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        reachability.stopNotifier()
    }
}
