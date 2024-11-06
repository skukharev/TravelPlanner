//
//  AppSettings.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation

class AppSettings: ObservableObject {
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
        UserDefaults.standard.setValue(newValue, forKey: Constants.useDarkThemeKey)
    }

    // MARK: - Private Methods

    private func loadDarkModeSetting() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.useDarkThemeKey)
    }
}
