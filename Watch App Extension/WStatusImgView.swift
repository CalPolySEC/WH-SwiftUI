//
//  WStatusImgView.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 7/12/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct WStatusImgView : View {
    let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
    var body: some View {
        Image(myDelegate.status)
            .resizable()
    }
}

#if DEBUG
struct WStatusImgView_Previews : PreviewProvider {
    static var previews: some View {
        WStatusImgView()
    }
}
#endif
