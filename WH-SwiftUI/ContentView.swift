//
//  ContentView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        VStack {
            Text("White Hat")
                .font(.largeTitle)
            HStack {
                StatusImgView()
                    .scaledToFit()
            }
                .padding()
            Spacer()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone XR"].identified(by: \.self)) { deviceName in
            ContentView()
        }
    }
}
#endif
