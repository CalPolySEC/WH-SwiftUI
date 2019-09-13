//
//  ReloadButton.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 9/12/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import SwiftUI

struct ReloadButton: View {
    
    @State var reload: Bool = false
    let delegate = WKExtension.shared().delegate as! ExtensionDelegate
    
    var body: some View {
        Button(action: {
            self.reload = true
            self.reloadFunc()
        }) {
            Text("Reload")
                .padding()
        }
    }
    
    func reloadFunc() {
        delegate.getJsonFromUrl()
        sleep(5)
        self.reload = false
    }
}

struct ReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        ReloadButton()
    }
}
