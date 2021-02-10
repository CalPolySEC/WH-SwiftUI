//
//  VideoView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/12/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct VideoView: View {
    var video: Video
    var body: some View {
        HStack {
            URLImage(URL(string: video.img)!,
                     processors: [ Resize(size: CGSize(width: 150.0, height: 84.375), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(6)
            })
                .frame(width: 75.0, height: 42.1875)
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

