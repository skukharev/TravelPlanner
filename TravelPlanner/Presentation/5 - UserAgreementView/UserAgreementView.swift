//
//  UserAgreementView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import SwiftUI
import WebKit

struct UserAgreementView: View {
    // MARK: - Types

    private enum Constants {
        static let userAgreementURL: String = "https://yandex.ru/legal/practicum_offer/"
    }

    // MARK: - Property Wrappers

    @State private var isLoading = true
    @State private var loadingProgress: Double = 0.0
    @State private var isLoadingError = false

    // MARK: - Public Properties

    var body: some View {
        VStack {
            ProgressView(value: loadingProgress)
                .progressViewStyle(.linear)
                .opacity(loadingProgress == 1.0 ? 0 : 1)
            ZStack {
                WebView(
                    url: Constants.userAgreementURL,
                    isLoading: $isLoading,
                    isLoadingError: $isLoadingError,
                    progress: $loadingProgress
                )
                .opacity(isLoadingError ? 0 : 1)
                ProgressView()
                    .opacity(isLoading ? 1 : 0)
                ErrorView(errorType: .noInternetError)
                    .opacity(isLoadingError ? 1 : 0)
            }
        }
        .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        .navigationTitle(L10n.settingsViewUserAgreementLabel)
        .navigationBarBackButtonTitleHidden()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            isLoading = true
            loadingProgress = 0.0
            isLoadingError = false
        }
    }
}

#Preview {
    UserAgreementView()
}
