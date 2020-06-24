//
//  VideoDetailView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct EventDetailView: View {
    var event: Dictionary<String, String>
    var body: some View {
        VStack {
            VStack {
                HStack{
                    Text(event["time"]!)
                        .font(.headline)
                        .padding(5)
                    Spacer()
                }
                HStack{
                    Text(event["location"]!)
                        .font(.body)
                        .padding(5)
                    Spacer()
                }
            }
            Spacer()
        }.navigationBarTitle(event["title"]!)
    }
}
