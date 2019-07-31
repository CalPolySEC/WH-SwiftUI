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
import SocketIO

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var npData: Dictionary<String, String>!
    var ssid: String!
    var ssidBool: Bool!
    var window: UIWindow?
    var status: String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getJsonFromUrl()
        let _ = checkSpotifyLoad()
        var i = 0;
        while (status == nil && i <= 10) {
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
    
    func getJsonFromUrl() {
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
                print(jStatus2)
                self.status = jStatus2
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
    
    var manager:SocketManager!
    var socket:SocketIOClient!
    
    func checkSpotifyLoad() -> String {
        let netType = "Wifi"
        if (netType == "Wifi") {
            let ssid = getSSID() ?? "nope"
            self.ssid = ssid
            print(self.ssid!)
            if (ssid == "SecurityLab-5G" || ssid == "SecurityLab" || ssid == "l33th4x:)") {
                self.ssidBool = true
                self.manager = SocketManager(socketURL: URL(string: "http://play.wh")!, config: [.log(true), .compress, .reconnects(true)])
                self.socket = self.manager.socket(forNamespace: "/devices")
                
                self.socket.on(clientEvent: .connect) {data, ack in
                    self.socket.emit("test", ["data": "Hello from iOS!"])
                    self.socket.emit("get_nowplaying")
                }
                self.socket.on("nowplaying") { (data, ack) -> Void in
                    let dataArray: Array = data as Array
                    let dataDict: Dictionary = dataArray[0] as! Dictionary<String, Any>
                    self.npData = (dataDict["data"] as! Dictionary<String, String>)
                }
                self.socket.on("refresh") {data, ack in
                    self.socket.emit("get_nowplaying")
                }
                self.socket.connect()
            }
            else {
                self.ssidBool = false
                self.npData = ["artist": "Sick Individuals", "track": "Right Next to You (feat. Kepler)", "uri": "https://open.spotify.com/track/6OVDJvTvaBRHjpS5f5aNBL?si=NZGnSVAkSo-0cwSAQKbCnA", "img": "https://i.scdn.co/image/b16a8403c3a12cdb27fa758bad43aa23df79abad"]
            }
        }
        return netType
    }
    
    func getSSID() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}
