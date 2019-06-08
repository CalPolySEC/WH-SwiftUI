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
            Text("White Hat")
                .font(.largeTitle)
            Image(delegate.status)
            Spacer()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XR", "iPhone XS Max"].identified(by: \.self)) { deviceName in
            ContentView()
        }
    }
}
#endif
