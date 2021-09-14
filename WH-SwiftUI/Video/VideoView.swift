//
//  VideoView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/12/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoView: View {
    var video: Video
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: video.img)!) { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
                    .opacity(0.2)
            }
            .frame(width: 75.0, height: 42.1875)
            .mask(RoundedRectangle(cornerRadius: 6.0))
            VStack {
                Spacer()
                HStack {
                    Text(video.title)
                        .font(.custom("Helvetica", size: 16))
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(video.speaker)
                        .font(.custom("Helvetica", size: 14))
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

