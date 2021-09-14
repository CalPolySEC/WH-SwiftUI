//
//  OfficersListView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 2/10/21.
//  Copyright © 2021 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct OfficerListView: View {
    @ObservedObject var networkManager: OfficerNetworkManager
    var body: some View {
        List(networkManager.officers.positions, id: \.self) { position in
            OfficerView(officer: networkManager.officers.officers[position] ?? Officer(image: "nil", name: "nil", position: "nil"))
                .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 3, trailing: 0))
        }
        .refreshable {
            networkManager.loadData()
        }
        .navigationBarTitle("Officers")
    }
}

