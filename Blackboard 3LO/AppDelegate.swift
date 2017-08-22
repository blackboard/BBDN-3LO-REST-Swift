//
//  AppDelegate.swift
//  Blackboard 3LO
//
//  Created by Scott Hurrey on 8/18/17.
//  Copyright © 2017 Blackboard Developer Community. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    @nonobjc func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        print("DEBUG: I'm in the wrong place")
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        Blackboard3LOManager.sharedInstance.processOAuthStep1Response(url: url)
        return true
    }
}

