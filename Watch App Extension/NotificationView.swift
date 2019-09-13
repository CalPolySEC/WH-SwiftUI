//
//  NotificationView.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct NotificationView : View {
    
    let delegate = WKExtension.shared().delegate as! ExtensionDelegate
    
    var body: some View {
        VStack {
            HStack {
                Image(delegate.status)
                .resizable()
                .scaledToFit()
            }
            .padding()
            Spacer()
        }
    }
}

#if DEBUG
struct NotificationView_Previews : PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
#endif
