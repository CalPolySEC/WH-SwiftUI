//
//  VideoListView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoListView: View {
    @ObservedObject var networkManager: VideoNetworkManager
    var body: some View {
        List(networkManager.videos.videos, id: \.self) { vid in
            NavigationLink(destination: VideoDetailView(video: vid)) {
                VideoView(video: vid)
                    .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 3, trailing: 0))
            }
        }
        .refreshable {
            networkManager.loadData()
        }
        .navigationBarTitle("All Videos")
    }
}
