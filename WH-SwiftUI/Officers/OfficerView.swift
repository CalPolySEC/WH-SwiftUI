//
//  OfficerView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/10/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import URLImage
import SwiftUI

struct OfficerView: View {
    var officer: Officer
    var body: some View {
        HStack {
            URLImage(URL(string: "https://thewhitehat.club/officers-" + officer.image)!,
                     processors: [ Resize(size: CGSize(width: 75.0, height: 75.0), scale: UIScreen.main.scale) ],
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(6.0)
            })
                .frame(width: 75.0, height: 75.0)
            VStack {
                Spacer()
                HStack {
                    Text(officer.name)
                        .font(.custom("Helvetica", size: 16))
                    Spacer()
                }
                Spacer()
                HStack {
                    Text(officer.position)
                        .font(.custom("Helvetica", size: 14))
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
