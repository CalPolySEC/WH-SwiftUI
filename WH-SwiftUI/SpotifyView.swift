//
//  SpotifyView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 7/29/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct SpotifyView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        HStack {
            URLImage(URL(string: self.delegate.npData["img"]!)!,
            processors: [ Resize(size: CGSize(width: 100.0, height: 100.0), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            })
                .frame(width: 100.0, height: 100.0)
            VStack {
                HStack {
                    Text(delegate.npData["track"]!)
                        .font(.custom("Helvetica", size: 16))
                        .padding(2)
                    Spacer()
                }
                HStack {
                    Text(delegate.npData["artist"]!)
                        .font(.custom("Helvetica", size: 14))
                        .padding(2)
                    Spacer()
                }
                Spacer()
                HStack {
                    Button(action: {
                        UIApplication.shared.open(URL(string: self.delegate.npData["uri"]!)!)
                    }) {
                        Text("Open in Spotify")
                            .font(.custom("Helvetica", size: 14))
                            .foregroundColor(.green)
                            .padding(2)
                    }
                    Spacer()
                }
                Spacer()
            }
            .frame(height: 100)
        }
        .padding()
    }
}

#if DEBUG
struct SpotifyView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyView()
    }
}
#endif
