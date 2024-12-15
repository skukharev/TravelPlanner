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
        static let navigationTitle = L10n.settingsViewUserAgreementLabel
    }

    // MARK: - Property Wrappers

    @StateObject private var viewModel = UserAgreementViewModel()

    // MARK: - Public Properties

    var body: some View {
        VStack {
            ProgressView(value: viewModel.loadingProgress)
                .progressViewStyle(.linear)
                .opacity(viewModel.loadingProgress == 1.0 ? 0 : 1)
            ZStack {
                WebView(
                    url: Constants.userAgreementURL,
                    isLoading: $viewModel.isLoading,
                    isLoadingError: $viewModel.isLoadingError,
                    progress: $viewModel.loadingProgress
                )
                .opacity(viewModel.isLoadingError ? 0 : 1)
                ProgressView()
                    .opacity(viewModel.isLoading ? 1 : 0)
                ErrorView(errorType: .noInternetError)
                    .opacity(viewModel.isLoadingError ? 1 : 0)
            }
        }
        .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        .navigationTitle(Constants.navigationTitle)
        .navigationBarBackButtonTitleHidden()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.initialize()
        }
    }
}

#Preview {
    UserAgreementView()
}
