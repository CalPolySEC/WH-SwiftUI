//
//  VideoScroll.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct VideoScrollView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        VStack(alignment: .leading) {
            Text("Videos")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(0...9, id:\.self) { i in
                        NavigationLink(
                            destination: VideoDetailView(
                                video: self.delegate.vdData[i]
                            )
                        ) {
                            VideoScroll(video: self.delegate.vdData[i])
                        }
                    }
                }
            }
            .frame(height: 120)
        }
    }
}

struct VideoScroll_Previews: PreviewProvider {
    static var previews: some View {
        VideoScrollView()
    }
}
