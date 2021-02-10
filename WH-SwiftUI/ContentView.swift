//
//  ContentView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObservedObject var vidNetworkManager = VideoNetworkManager()
    @ObservedObject var stNetworkManager = StatusNetworkManager()
    @ObservedObject var ofNetworkManager = OfficerNetworkManager()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    @State private var selectedView: Int? = 0
    var body: some View {
        NavigationView {
            List {
                
                if stNetworkManager.loading {
                    Text("Loading...")
                } else {
                    HStack {
                        Spacer()
                        StatusImgView(networkManager: stNetworkManager)
                            .frame(height: 50)
                            .scaledToFit()
                        Spacer()
                    }
                }
                
                if delegate.npData["track"] != "nil" {
                    SpotifyView()
                }
                
                if vidNetworkManager.loading {
                    Text("Loading...")
                } else {
                    VideoScrollView(networkManager: vidNetworkManager).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0 ))
                }
                NavigationLink(destination: VideoListView(networkManager: vidNetworkManager), tag: 1, selection: self.$selectedView) {
                    Text("All Videos")
                }
                
                EventScrollView().listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 7, trailing: 0 ))
                NavigationLink(destination: EventListView()) {
                    Text("All Events")
                }
                
                if ofNetworkManager.loading {
                    Text("Loading...")
                } else {
                    NavigationLink(
                        destination: OfficerListView(networkManager: ofNetworkManager),
                        label: {
                            Text("Officers")
                        })
                }
                
                NavigationLink(destination: EmailView()) {
                    Text("Join Mailing List")
                }
            }
            .onAppear{
                if DeviceTypeAndOrientation.isiPad && DeviceTypeAndOrientation.isLandscape {
                    self.selectedView = 1
                } else {
                    self.selectedView = 0
                }
            }
            .navigationBarTitle(Text("White Hat"))
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

enum DeviceTypeAndOrientation {
    static var isiPad: Bool {
        return UIView().traitCollection.horizontalSizeClass == .regular && UIView().traitCollection.verticalSizeClass == .regular
    }

    static var isLandscape: Bool {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
#endif
