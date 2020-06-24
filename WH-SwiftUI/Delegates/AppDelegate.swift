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
    var ssid: String!
    var ssidBool: Bool!
    var window: UIWindow?
    var status: String!
    var vdData: Array<Dictionary<String, String>>!
    var count: Int!

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
        spotBotData()
        getJsonFromUrlSt()
        getJsonFromUrlVd()
        var i = 0;
        while (status == nil && i <= 10) {
            sleep(1)
            i += 1
        }
        i = 0
        while (npData["artist"] == "nil" && i <= 0) {
            print(npData["artist"]!)
            sleep(1)
            i += 1
        }
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
    
    // MARK: Custom Functions
    
    func getJsonFromUrlSt() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        
        let url = URL(string: "https://thewhitehat.club/api/v1/status")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let jStatus = json["data"] as? Dictionary<String, Any>
                let jStatus2 = jStatus?["status"] as? String ?? "nil"
                self.status = jStatus2
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    func getJsonFromUrlVd() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        
        let url = URL(string: "https://thewhitehat.club/api/v1/videos")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let jStatus = json["data"] as? Dictionary<String, Any>
                let jStatus2 = jStatus?["videos"] as? Array<Dictionary<String, String>>
                self.vdData = jStatus2
                let jsondata = json["data"] as? Dictionary<String, Int>
                let jsoncount = jsondata?["count"]!
                self.count = jsoncount
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
//    var manager:SocketManager!
//    var socket:SocketIOClient!
//
//    func spotBotSock() {
//        self.manager = SocketManager(socketURL: URL(string: "http://10.13.37.7")!, config: [.log(true), .compress, .reconnects(true)])
//        self.socket = self.manager.socket(forNamespace: "/devices")
//
//        self.socket.on(clientEvent: .connect) {data, ack in
//            self.socket.emit("test", ["data": "Hello from iOS!"])
//            self.socket.emit("get_nowplaying")
//        }
//        self.socket.on("nowplaying") { (data, ack) -> Void in
//            let dataArray: Array = data as Array
//            let dataDict: Dictionary = dataArray[0] as! Dictionary<String, Any>
//            self.npData = (dataDict["data"] as! Dictionary<String, String>)
//        }
//        self.socket.on("refresh") {data, ack in
//            self.socket.emit("get_nowplaying")
//        }
//        self.socket.connect()
//
//    }
    
    func spotBotData() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession.init(configuration: config)

        let url = URL(string: "http://10.13.37.7/api/v1/info")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print(json)
                let jStatus = json as Dictionary<String, Any>
                let artist = jStatus["artist"] as? String ?? "nil"
                let track = jStatus["track"] as? String ?? "nil"
                let img = jStatus["img"] as? String ?? "nil"
                let uri = jStatus["uri"] as? String ?? "nil"
                print(uri)
                self.npData = ["artist":artist, "track":track, "uri":uri, "img":img]
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
}
