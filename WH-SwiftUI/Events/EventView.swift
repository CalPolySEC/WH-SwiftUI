//
//  VideoView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/12/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import URLImage

struct EventView: View {
    var event: Dictionary<String, String>
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        VStack(alignment: .leading) {
            Text(event["title"]!)
                .foregroundColor(.primary)
                .font(.footnote)
            Text(event["time"]!)
                .foregroundColor(.primary)
                .font(.caption)
            Text(event["location"]!)
                .foregroundColor(.primary)
                .font(.caption)
                
        }
        .padding(.leading, 15)
    }
}

