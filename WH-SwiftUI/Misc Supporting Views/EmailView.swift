//
//  EmailView.swift
//  WH-SwiftUI
//
//  Created by Stephen Parkinson on 6/23/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import SwiftUI
import WebKit

struct EmailView: View {
    var body: some View {
        WebView()
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}

struct WebView: UIViewRepresentable {

    func makeUIView(context: Context) -> WKWebView {
        WKWebView(frame: .zero)
    }

    func updateUIView(_ view: WKWebView, context: UIViewRepresentableContext<WebView>) {

        let request = URLRequest(url: URL(string: "https://thewhitehat.club/signup")!)

        view.load(request)
    }
}
