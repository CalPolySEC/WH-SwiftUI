//
//  StatusImgView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 7/1/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct StatusImgView : View {
    var networkManager: StatusNetworkManager
    var body: some View {
        Button(action: {
            UIApplication.shared.open(URL(string: "http://thewhitehat.club")!)
        }) {
            VStack {
                Image(networkManager.status.status)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(3.8, contentMode: .fit)
            }
            .frame(height: 50)
        }
    }
}
