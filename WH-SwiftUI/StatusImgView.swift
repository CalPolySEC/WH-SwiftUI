//
//  StatusImgView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 7/1/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct StatusImgView : View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        Image(delegate.status)
            .resizable()
    }
}

#if DEBUG
struct StatusImgView_Previews : PreviewProvider {
    static var previews: some View {
        StatusImgView()
    }
}
#endif
