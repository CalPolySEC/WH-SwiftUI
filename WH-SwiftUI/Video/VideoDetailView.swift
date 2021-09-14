//
//  VideoDetailView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoDetailView: View {
    var video: Video
    var body: some View {
        VStack {
            Button(action: {
                UIApplication.shared.open(URL(string: self.video.url)!)
            }) {
                ZStack{
                    AsyncImage(url: URL(string: self.video.img)!) { image in
                        image
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Color.gray
                            .opacity(0.2)
                    }
                    .frame(width: UIScreen.main.focusedView?.bounds.size.width ?? 320.0, height: (0.5625*(UIScreen.main.focusedView?.bounds.size.height ?? 320.0)))
                    .mask(RoundedRectangle(cornerRadius: 6.0))
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
