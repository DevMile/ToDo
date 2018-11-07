//
//  AppDelegate.swift
//  ToDo
//
//  Created by Milan Bojic on 10/30/18.
//  Copyright © 2018 Milan Bojic. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // file url to Realm file
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    
   
    
}

