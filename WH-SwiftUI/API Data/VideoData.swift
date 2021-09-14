//
//  videoData.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/9/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import Combine
import SwiftUI

struct Video: Decodable, Hashable {
    var description: String
    var id: String
    var img: String
    var speaker: String
    var title: String
    var uploaded: String
    var url: String
}

struct VideoList: Decodable {
    var videos: [Video]
}
extension VideoList {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(VideoList.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}

class VideoNetworkManager: ObservableObject {
    @Published var videos = VideoList(videos: [])
    @Published var loading = false
    
    init() {
        loading = true
        loadData()
    }
    
    public func loadData() {
        guard let url = URL(string: "https://cpsecurity.club/api/v1/videos") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
          guard let data = data else { return }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let jData = parsedData["data"] as! [String:Any]
                let videos = try VideoList(dictionary: jData)
                DispatchQueue.main.async {
                    self.videos = videos
                    self.loading = false
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
}
