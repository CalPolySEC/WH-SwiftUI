//
//  OfficerData.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/10/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import Combine
import SwiftUI

struct Officer: Decodable {
    var image: String
    var name: String
    var position: String
}

struct Officers: Decodable {
    var positions: [String]
    var officers: [String:Officer]
}
extension Officers {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Officers.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}

class OfficerNetworkManager: ObservableObject {
    @Published var officers = Officers(positions: [], officers: [:])
    @Published var loading = false
    
    init() {
        loading = true
        loadData()
    }
    
    public func loadData() {
        guard let url = URL(string: "https://cpsecurity.club/api/v1/officers") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
          guard let data = data else { return }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let jData = parsedData["data"] as! [String:Any]
                let officers = try Officers(dictionary: jData)
                DispatchQueue.main.async {
                    self.officers = officers
                    self.loading = false
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
}
