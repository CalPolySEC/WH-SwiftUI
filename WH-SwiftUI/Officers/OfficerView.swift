//
//  OfficerView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/10/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct OfficerView: View {
    var officer: Officer
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://cpsecurity.club/officers-" + officer.image)!) { image in
                image
                    .renderingMode(.original)
                    .resizable()
            } placeholder: {
                Color.gray
                    .opacity(0.2)
            }
            .frame(width: 75.0, height: 75.0)
            .mask(RoundedRectangle(cornerRadius: 6.0))
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
