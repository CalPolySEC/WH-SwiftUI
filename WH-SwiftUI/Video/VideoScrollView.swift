//
//  VideoScroll.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoScrollView: View {
    @ObservedObject var networkManager: VideoNetworkManager
    var body: some View {
        VStack(alignment: .leading) {
            Text("Videos")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            if !networkManager.videos.videos.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(0...9, id: \.self) { i in
                            NavigationLink(destination: VideoDetailView(video: networkManager.videos.videos[i])) {
                                VideoScroll(video: networkManager.videos.videos[i])
                            }
                        }
                    }
                }
                .frame(height: 120)
            }
        }
    }
}
