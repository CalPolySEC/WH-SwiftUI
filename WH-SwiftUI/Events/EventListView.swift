//
//  VideoListView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/21/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct EventListView: View {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var body: some View {
        List {
            ForEach(delegate.evData, id: \.self) { evt in
                NavigationLink(destination: EventDetailView(event: evt)) {
                    EventView(event: evt)
                        .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 3, trailing: 0))
                }
            }
        }.navigationBarTitle("All Events")
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
