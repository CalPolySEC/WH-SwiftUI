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
        NavigationView {
            List {
                
                HStack {
                    Spacer()
                    StatusImgView()
                        .frame(height: 50)
                        .scaledToFit()
                    Spacer()
                }
                
                if delegate.npData["track"] != "nil" {
                    SpotifyView()
                }
                
                VideoScrollView().listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0 ))
                NavigationLink(destination: VideoListView()) {
                    Text("All Videos")
                }
                
                EventScrollView().listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0 ))
                NavigationLink(destination: EventListView()) {
                    Text("All Events")
                }
                
                NavigationLink(destination: EmailView()) {
                    Text("Join Mailing List")
                }
            }
            .navigationBarTitle(Text("White Hat"))
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
