//
//  EventTile.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 9/13/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct EventTile: View {
    var body: some View {
        HStack {
            Image("nil")
                .resizable()
                .frame(width: 50, height: 50)
            VStack {
                HStack {
                    Text("Event Name")
                        .font(.custom("Helvetica", size: 16))
                    Spacer()
                }
                HStack {
                    Text("Event Location")
                        .font(.custom("Helvetica", size: 14))
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(height: 50)
    }
}

struct EventTile_Previews: PreviewProvider {
    static var previews: some View {
        EventTile()
    }
}
