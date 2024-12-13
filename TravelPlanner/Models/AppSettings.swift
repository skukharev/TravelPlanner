//
//  AppSettings.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import SwiftUI

final class AppSettings: ObservableObject {
    // MARK: - Constants

    private enum Constants {
        static let useDarkThemeKey = "useDarkTheme"
    }

    // MARK: - Public Properties

    @AppStorage(Constants.useDarkThemeKey)
    var isDarkMode: Bool?

    // MARK: - Public Methods

    func loadAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }
}
