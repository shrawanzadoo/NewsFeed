//
//  AppDelegate.swift
//  News Feed
//
//  Created by Shrawan Zadoo on 07/07/2019.
//  Copyright © 2019 Shrawan Zadoo. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Homedir: \(NSHomeDirectory())")
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.saveContext()
    }
}

