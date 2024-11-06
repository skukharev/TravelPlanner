//
//  SettingsViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var appVersionText: String = ""

    // MARK: - Initializers

    init() {
        appVersionText = L10n.yandexAPIVersion + " " + loadAppVersion()
    }

    // MARK: - Private Methods

    private func loadAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let version = nsObject as? String
        else {
            return ""
        }
        return version
    }
}
