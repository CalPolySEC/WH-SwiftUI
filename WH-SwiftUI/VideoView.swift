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
    var video: Dictionary<String, String>
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        HStack {
            URLImage(URL(string: video["img"]!)!,
                     processors: [ Resize(size: CGSize(width: 50.0, height: 50.0), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            })
                .frame(width: 50.0, height: 50.0)
        Button(action: {
            UIApplication.shared.open(URL(string: self.video["url"]!)!)
        }) {
                VStack {
                    Spacer()
                    HStack {
                        Text(video["title"]!)
                            .font(.custom("Helvetica", size: 16))
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Text(video["speaker"]!)
                            .font(.custom("Helvetica", size: 14))
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
}

