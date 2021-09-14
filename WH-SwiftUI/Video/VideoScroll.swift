//
//  VideoScrollView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoScroll: View {
    var video: Video
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: video.img)!) { image in
                image
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
                    .opacity(0.2)
            }
                .frame(width: 155, height: 155*0.5625)
                .mask(RoundedRectangle(cornerRadius: 6.0))
            Text(video.title)
                .foregroundColor(.primary)
                .font(.footnote)
                .truncationMode(.tail)
                .frame(width: 155, alignment: .leading)
            Text(video.speaker)
                .foregroundColor(.primary)
                .font(.caption)
                .truncationMode(.tail)
                .frame(width: 155, alignment: .leading)
        }
        .padding(.leading, 15)

    }
}
