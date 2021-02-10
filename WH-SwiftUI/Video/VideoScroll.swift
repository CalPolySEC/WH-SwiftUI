//
//  VideoScrollView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct VideoScroll: View {
    var video: Video
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(URL(string: video.img)!,
                     processors: [ Resize(size: CGSize(width: 200.0, height: 200.0*0.5625), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .renderingMode(.original)
                    .resizable()
                    .cornerRadius(5)
            })
            .frame(width: 155, height: 155*0.5625)
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
