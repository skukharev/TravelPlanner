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

    @StateObject var viewModel = WebView.ProgressViewModel(progress: 0.0)

    var body: some View {
        VStack {
            ProgressView(value: viewModel.progress)
                .progressViewStyle(.linear)
                .isHidden(viewModel.progress == 1.0)
            WebView(
                url: Constants.userAgreementURL,
                viewModel: viewModel
            )
        }
        .ignoresSafeArea(.all)
        .navigationTitle(L10n.settingsViewUserAgreementLabel)
    }
}

#Preview {
    UserAgreementView()
}
