//
//  Data.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/4/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import UIKit
import SwiftUI

let videoData: [Video] = getJsonFromUrl()
getJsonFromUrl()

func getJsonFromUrl() -> [Video] {
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
            videoData = jStatus?["videos"] as? [Video]
        } catch let error as NSError {
            print(error)
        }
    }).resume()
}
