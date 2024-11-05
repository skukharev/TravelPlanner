//
//  SettingsView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 30.10.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appSettings: AppSettings

    var body: some View {
        VStack {
            HStack {
                Text(L10n.settingsViewDarkModeLabel)
                    .font(.system(size: 17))
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
                    .font(.system(size: 17))
                    .padding()
                Spacer()
                Button(action: userAgreementOnTap) {
                    Label("", systemImage: "chevron.right")
                        .labelStyle(.iconOnly)
                }
                .padding()
                .tint(.appBlack)
            }
            Spacer()
            Text(L10n.copyrightText)
                .font(.system(size: 12))
            Text(L10n.yandexAPIVersion)
                .font(.system(size: 12))
                .padding()
            Divider()
        }
    }

    private func userAgreementOnTap() {
    }
}

#Preview {
    let appSettings = AppSettings()

    SettingsView()
        .environmentObject(appSettings)
}
