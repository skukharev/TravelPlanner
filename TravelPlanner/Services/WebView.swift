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

    class Coordinator: NSObject {
        private var parent: WebView
        private var viewModel: ProgressViewModel
        private var observer: NSKeyValueObservation?

        init(_ parent: WebView, viewModel: ProgressViewModel) {
            self.parent = parent
            self.viewModel = viewModel
            super.init()

            observer = self.parent.webView.observe(\.estimatedProgress) { [weak self] webView, _ in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.parent.viewModel.progress = webView.estimatedProgress
                }
            }
        }

        deinit {
            observer = nil
        }
    }

    class ProgressViewModel: ObservableObject {
        @Published var progress: Double = 0.0

        init (progress: Double) {
            self.progress = progress
        }
    }

    // MARK: - Constants

    private let webView = WKWebView()

    // MARK: - Public Properties

    var url: String
    @ObservedObject var viewModel: ProgressViewModel

    func makeUIView(context: Context) -> WKWebView {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    // MARK: - Public Methods

    func updateUIView(_ webView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
}
