//
//  VideoDetailView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct VideoDetailView: View {
    var video: Video
    var body: some View {
        VStack {
            Button(action: {
                UIApplication.shared.open(URL(string: self.video.url)!)
            }) {
                ZStack{
                    URLImage(URL(string: video.img)!,
                             processors: [ Resize(size: CGSize(width: 160.0, height: 90.0), scale: UIScreen.main.scale) ],
                    content:  {
                        $0.image
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    })
                        .frame(width: UIScreen.main.bounds.size.width, height: (0.5625*UIScreen.main.bounds.size.width))
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 56.0))
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.white)
                }
            }
            VStack {
                HStack{
                    Text(video.speaker)
                        .font(.headline)
                        .padding(5)
                    Spacer()
                }
                HStack{
                    Text(video.description)
                        .font(.body)
                        .padding(5)
                    Spacer()
                }
            }
            Spacer()
        }.navigationBarTitle(video.title)
    }
}
