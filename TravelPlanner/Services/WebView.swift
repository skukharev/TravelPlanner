//
//  WebView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 06.11.2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // MARK: - Types

    class Coordinator: NSObject, WKNavigationDelegate {
        private var parent: WebView
        private var observer: NSKeyValueObservation?

        init(_ parent: WebView) {
            self.parent = parent
            super.init()
            self.parent.webView.navigationDelegate = self

            observer = self.parent.webView.observe(\.estimatedProgress) { [weak self] webView, _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.parent.progress = webView.estimatedProgress
                }
            }
        }

        deinit {
            observer = nil
        }

        // swiftlint:disable:next implicitly_unwrapped_optional
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = true
            }
        }

        // swiftlint:disable:next implicitly_unwrapped_optional
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
            }
        }

        // swiftlint:disable:next implicitly_unwrapped_optional
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.isLoading = false
                self.parent.progress = 0.0
                self.parent.isLoadingError = true
            }
        }
    }

    // MARK: - Constants

    private let webView = WKWebView()

    // MARK: - Public Properties

    var url: String
    @Binding var isLoading: Bool
    @Binding var isLoadingError: Bool
    @Binding var progress: Double

    // MARK: - Public Methods

    func makeUIView(context: Context) -> WKWebView {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
