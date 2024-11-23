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

    // MARK: - Public Properties

    var body: some View {
        VStack {
            ProgressView(value: loadingProgress)
                .progressViewStyle(.linear)
                .isHidden(loadingProgress == 1.0)
            ZStack {
                WebView(
                    url: Constants.userAgreementURL,
                    isLoading: $isLoading,
                    isLoadingError: $isLoadingError,
                    progress: $loadingProgress
                )
                    .isHidden(isLoadingError)
                ProgressView()
                    .isHidden(!isLoading)
                ErrorView(errorType: .noInternetError)
                    .isHidden(!isLoadingError)
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

    // MARK: - Public Properties

    @State private var isLoading = true
    @State private var loadingProgress: Double = 0.0
    @State private var isLoadingError = false
}

#Preview {
    UserAgreementView()
}
