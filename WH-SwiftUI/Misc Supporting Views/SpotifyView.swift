//
//  SpotifyView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 7/29/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct SpotifyView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: self.delegate.npData["img"]!)!) { image in
                image
                    .renderingMode(.original)
                    .resizable()
            } placeholder: {
                Color.gray
                    .opacity(0.2)
            }
            .frame(width: 100.0, height: 100.0)
            .mask(RoundedRectangle(cornerRadius: 3.0))
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
    }
}

#if DEBUG
struct SpotifyView_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyView()
    }
}
#endif
