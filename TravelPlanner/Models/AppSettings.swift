//
//  AppSettings.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    // MARK: - Constants

    private enum Constants {
        static let useDarkThemeKey = "useDarkTheme"
    }

    // MARK: - Public Properties

    @Published var isDarkMode: Bool = false

    // MARK: - Initializers

    init() {
        isDarkMode = UserDefaults.standard.bool(forKey: Constants.useDarkThemeKey)
    }

    // MARK: - Public Methods

    public func saveDarkModeSetting(with newValue: Bool) {
        UserDefaults.standard.setValue(newValue, forKey: Constants.useDarkThemeKey)
    }
}
