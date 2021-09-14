//
//  StatusData.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/9/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import Combine
import SwiftUI

struct Status: Decodable {
    var status: String
}
extension Status {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Status.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}

class StatusNetworkManager: ObservableObject {
    @Published var status = Status(status: "")
    @Published var loading = false
    
    init() {
        loading = true
        loadData()
    }
    
    private func loadData() {
        guard let url = URL(string: "https://cpsecurity.club/api/v1/status") else { return }
        URLSession.shared.dataTask(with: url){ (data, _, _) in
          guard let data = data else { return }
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let jData = parsedData["data"] as! [String:Any]
                let status = try Status(dictionary: jData)
                DispatchQueue.main.async {
                    self.status = status
                    self.loading = false
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
}
