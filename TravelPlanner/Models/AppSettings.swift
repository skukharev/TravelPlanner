//
//  AppSettings.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation

final class AppSettings: ObservableObject {
    // MARK: - Constants

    private enum Constants {
        static let useDarkThemeKey = "useDarkTheme"
    }

    // MARK: - Public Properties

    @Published var isDarkMode: Bool = false

    // MARK: - Initializers

    init() {
        isDarkMode = loadDarkModeSetting()
    }

    // MARK: - Public Methods

    public func saveDarkModeSetting(with newValue: Bool) {
        isDarkMode = newValue
        UserDefaults.standard.setValue(newValue, forKey: Constants.useDarkThemeKey)
    }

    public func loadAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }

    // MARK: - Private Methods

    private func loadDarkModeSetting() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.useDarkThemeKey)
    }
}
