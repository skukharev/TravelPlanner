//
//  SettingsView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 30.10.2024.
//

import SwiftUI

struct SettingsView: View {
    private enum Constants {
        static let settingsViewDarkModeLabelFont = GlobalConstants.ypRegular17
        static let settingsViewUserAgreementLabelFont = GlobalConstants.ypRegular17
        static let copyrightTextFont = GlobalConstants.ypRegular12
        static let yandexAPIVersionFont = GlobalConstants.ypRegular12
    }

    @StateObject var viewModel = SettingsViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    @State private var showUserAgreementView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(L10n.settingsViewDarkModeLabel)
                        .font(Constants.settingsViewDarkModeLabelFont)
                        .padding()
                    Spacer()
                    Toggle("", isOn: $appSettings.isDarkMode)
                        .padding()
                        .tint(.blueUniversal)
                        .onChange(of: appSettings.isDarkMode) { isDarkMode in
                            appSettings.saveDarkModeSetting(with: isDarkMode)
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
                    NavigationLink(destination: UserAgreementView(), isActive: $showUserAgreementView) {
                        EmptyView()
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
    }

    private func userAgreementOnTap() {
        showUserAgreementView = true
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSettings())
}
