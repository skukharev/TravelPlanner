//
//  SettingsView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 30.10.2024.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Types

    private enum Constants {
        static let settingsViewDarkModeLabelFont = GlobalConstants.ypRegular17
        static let settingsViewUserAgreementLabelFont = GlobalConstants.ypRegular17
        static let copyrightTextFont = GlobalConstants.ypRegular12
        static let yandexAPIVersionFont = GlobalConstants.ypRegular12
    }

    // MARK: - Property Wrappers

    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject private var appSettings: AppSettings

    // MARK: - Public Properties

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(L10n.settingsViewDarkModeLabel)
                        .font(Constants.settingsViewDarkModeLabelFont)
                        .padding()
                    Spacer()
                    Toggle("", isOn: $viewModel.isDarkMode)
                        .padding()
                        .tint(.blueUniversal)
                        .onChange(of: viewModel.isDarkMode) { isDarkMode in
                            viewModel.saveDarkMode(isDarkMode: isDarkMode)
                        }
                }
                HStack {
                    Text(L10n.settingsViewUserAgreementLabel)
                        .font(Constants.settingsViewUserAgreementLabelFont)
                        .padding()
                    Spacer()
                    Button(action: userAgreementOnTap) {
                        Label("", systemImage: "chevron.right")
                            .labelStyle(.iconOnly)
                    }
                    .padding()
                    .tint(.appBlack)
                    .fullScreenCover(isPresented: $viewModel.isShowUserAgreementView) {
                        NavigationStack {
                            NavigationLink("", value: "UserAgreementView")
                                .navigationDestination(isPresented: $viewModel.isShowUserAgreementView) {
                                    UserAgreementView()
                                }
                        }
                    }
                }
                Spacer()
                Text(L10n.copyrightText)
                    .font(Constants.copyrightTextFont)
                Text(viewModel.appVersionText)
                    .font(Constants.yandexAPIVersionFont)
                    .padding()
                Divider()
            }
        }
        .tint(.appBlack)
        .onAppear {
            self.viewModel.setup(self.appSettings)
        }
    }

    // MARK: - Private Methods

    private func userAgreementOnTap() {
        viewModel.showUserAgreementView()
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}
