//
//  AppDelegate.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration.CaptiveNetwork
import CoreTelephony

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var npData: Dictionary<String, String>!
    var evData: Array<Dictionary<String, String>>!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        npData = ["artist":"nil", "track":"nil", "uri":"nil", "img":"nil"]
        evData = [
            ["title":"Test Event1", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event2", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event3", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event4", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event5", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event6", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event7", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event8", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event9", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event10", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event11", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event12", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event13", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event14", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event14", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"],
            ["title":"Test Event15", "location":"197-204", "time":"2007-04-05T14:30", "longitude":"-120.665060", "latitude":"35.302268"]
        ]
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
