//
//  ContentView.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import WatchKit

struct ContentView : View {
    
    @State var reloaded: Bool = false
    @State var status: String = "nil"
    let delegate = WKExtension.shared().delegate as! ExtensionDelegate
    
    var body: some View {
        VStack {
            HStack {
                if (reloaded) {
                    Image(status)
                        .resizable()
                        .scaledToFit()
                }
                else {
                    Image(delegate.status)
                        .resizable()
                        .scaledToFit()
                }
            }
            Button(action: {
                self.reloadFunc()
                }) {
                    Text("Reload")
                        .padding()
            }
            .padding()
            Spacer()
        }
    }
    
    func reloadFunc() {
        let watch = WKInterfaceDevice()
        watch.play(.start)
        let oldStat = status
        status = "nil"
        getJsonFromUrl()
        var i = 0;
        while (status == "nil" && i < 10) {
            sleep(1)
            i += 1;
        }
        if (oldStat != status) {
            watch.play(.success)
        }
        else {
            watch.play(.stop)
        }
        self.reloaded = true
    }
    
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
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
