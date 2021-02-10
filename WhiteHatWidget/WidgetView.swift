//
//  WidgetView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/24/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct WidgetView: View {
    var status: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(status)
                    .resizable()
                    .padding(-10)
            }
            Spacer()
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(status: "nil")
    }
}
