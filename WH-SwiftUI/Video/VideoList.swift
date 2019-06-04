//
//  VideoList.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/4/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoList : View {
    var body: some View {
        NavigationView {
            List(videoData) { video in
                NavigationButton(destination: VideoDetail(video: video)) {
                    LandmarkRow(video: video)
                }
                }
                .navigationBarTitle(Text("Videos"))
        }
    }
}

#if DEBUG
struct LandmarkList_Previews : PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XR"].identified(by: \.self)) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
        }
    }
}
#endif
