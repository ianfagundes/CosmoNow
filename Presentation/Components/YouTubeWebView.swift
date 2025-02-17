//
//  YouTubeWebView.swift
//  CosmoNow
//
//  Created by Ian Fagundes on 13/02/25.
//

import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    let videoURL: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: videoURL)
        webView.load(request)
    }
}
