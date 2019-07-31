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
    @State var ssidBoolLoc = false
    var body: some View {
        VStack {
            Text("White Hat")
                .font(.custom("FiraCode-Retina", size: 42))
            HStack {
                StatusImgView()
                    .scaledToFit()
            }
            .padding()
            Toggle(isOn: $ssidBoolLoc) {
                Text("SecLab")
            }
            .padding()
            Spacer()
            if (delegate.ssidBool || ssidBoolLoc) {
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
