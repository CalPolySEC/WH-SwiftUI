//
//  ExtensionDelegate.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import WatchKit
import ClockKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    
    var status: String!
    var emoji: String!
    var lab: String!
    var first: Int!

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        getJsonFromUrl()
        var i = 0;
        while (status == nil && i < 10) {
            sleep(1)
            i += 1;
        }
        if status == nil {
            status = "nil"
        }
        updateComplication()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        getJsonFromUrl()
        let oldStat = status
        status = nil
        getJsonFromUrl()
        var i = 0;
        while (status == nil && i < 10) {
            sleep(1)
            i += 1;
        }
        if (oldStat != status) {
            if status == nil {
                status = "nil"
            }
            updateComplication()
        }
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        self.getJsonFromUrl()
        sleep(10)
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                updateComplication()
                backgroundTask.setTaskCompletedWithSnapshot(false)
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                updateComplication()
                connectivityTask.setTaskCompletedWithSnapshot(false)
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                updateComplication()
                urlSessionTask.setTaskCompletedWithSnapshot(false)
            case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
                // Be sure to complete the relevant-shortcut task once you're done.
                updateComplication()
                relevantShortcutTask.setTaskCompletedWithSnapshot(false)
            case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
                // Be sure to complete the intent-did-run task once you're done.
                updateComplication()
                intentDidRunTask.setTaskCompletedWithSnapshot(false)
            default:
                // make sure to complete unhandled task types
                updateComplication()
                task.setTaskCompletedWithSnapshot(false)
            }
        }
    }
    
    func updateComplication() {
        let complicationServer = CLKComplicationServer.sharedInstance()
        if complicationServer.activeComplications != nil {
            for complication in complicationServer.activeComplications! {
                complicationServer.reloadTimeline(for: complication)
            }
        }
    }
    
    
    func getJsonFromUrl() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        
        let url = URL(string: "https://cpsecurity.club/api/v1/status")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let jStatus = json["data"] as? Dictionary<String, Any>
                let jStatus2 = jStatus?["status"] as? String ?? "nil"
                print(jStatus2)
                self.status = jStatus2
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
}
