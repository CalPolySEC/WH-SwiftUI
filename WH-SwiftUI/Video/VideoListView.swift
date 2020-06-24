//
//  VideoListView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoListView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        List {
            ForEach(delegate.vdData, id: \.self) { vid in
                NavigationLink(destination: VideoDetailView(video: vid)) {
                    VideoView(video: vid)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 3, trailing: 0))
                }
            }
        }.navigationBarTitle("All Videos")
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
