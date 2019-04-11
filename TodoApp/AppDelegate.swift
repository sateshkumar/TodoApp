//
//  AppDelegate.swift
//  TodoApp
//
//  Created by satesh kumar on 4/2/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
//
//        let data = Data()
//        data.name = "satesh"
//        data.age = 12
//
        do{
            
             _ = try Realm()
//             try realm.write {
          //  realm.add(data)
  //          }
            
        }
        catch {
            print("print error while initialize realm \(error)")
        }
        
       
        return true
    }

    
    func applicationWillTerminate(_ application: UIApplication) {
  
        
        }
    
    // MARK: - Core Data stack
    


}

