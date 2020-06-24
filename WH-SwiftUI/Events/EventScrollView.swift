//
//  VideoScroll.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct EventScrollView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        VStack(alignment: .leading) {
            Text("Events")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(0...4, id:\.self) { i in
                        NavigationLink(
                            destination: EventDetailView(
                                event: self.delegate.evData[i]
                            )
                        ) {
                            EventScroll(event: self.delegate.evData[i])
                        }
                    }
                }
            }
            .frame(height: 195)
        }
    }
}

struct EventScroll_Previews: PreviewProvider {
    static var previews: some View {
        EventScrollView()
    }
}
