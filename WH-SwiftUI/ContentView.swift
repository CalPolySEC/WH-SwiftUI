//
//  ContentView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        VStack {
            Text("WhiteHat")
                .font(.custom("FiraCode-Retina", size: 42))
            HStack {
                StatusImgView()
                    .frame(height: 50)
                    .scaledToFit()
            }
            VStack {
                HStack {
                    Text("Videos:")
                        .fontWeight(.heavy)
                        .font(.custom("Helvetica", size: 18))
                        .padding(5)
                    Spacer()
                }
                List{
                    ForEach(delegate.vdData, id: \.self) { vid in
                        VideoView(video: vid)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 3, trailing: 0))
                    }
                }
                Spacer()
            }
            if delegate.npData["track"] == "nil" {
                Spacer()
            }
            else {
                Spacer()
                SpotifyView()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
