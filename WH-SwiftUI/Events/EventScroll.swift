//
//  EventScroll.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/23/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import CoreLocation

struct EventScroll: View {
    var event: Dictionary<String, String>
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                let lat = Double(event["latitude"]!)
                let long = Double(event["longitude"]!)
                MapView(coordinate: CLLocationCoordinate2D(latitude: lat!, longitude: long!), interaction: false)
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: 155, height: 155)
                    .cornerRadius(5)
//                Text("186-302")
//                    .background(Color.black)
//                    .foregroundColor(.primary)
//                    .font(.callout)
//                    .offset(x:-50, y: -65)
//                    .frame(alignment: .leading)
            }
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
