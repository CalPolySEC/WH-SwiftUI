//
//  StatusImgView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 7/1/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct StatusImgView : View {
    @ObservedObject var networkManager: StatusNetworkManager
    var body: some View {
        Button(action: {
            UIApplication.shared.open(URL(string: "https://cpsecurity.club")!)
        }) {
            if networkManager.loading {
                Image(systemName: "hourglass")
            } else {
                Image(systemName: StatusToSFSymbol(status: networkManager.status.status))
            }
        }
    }
    
    func StatusToSFSymbol(status: String) -> String {
        switch status {
        case "closed":
            return "lock.fill"
        case "open":
            return "lock.open.fill"
        case "fire":
            return "flame"
        case "coffee":
            return "takeoutbag.and.cup.and.straw"
        default:
            return "facemask.fill"
        }
    }
}
