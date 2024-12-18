//
//  SettingsViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var appVersionText: String = ""
    @Published var isDarkMode: Bool = false
    @Published var isShowUserAgreementView: Bool = false

    // MARK: - Private Properties

    private var appSettings: AppSettings?

    // MARK: - Public Methods

    func setup(_ appSettings: AppSettings) {
        self.appSettings = appSettings
        appVersionText = L10n.yandexAPIVersion + " " + appSettings.loadAppVersion()
        isDarkMode = appSettings.isDarkMode ?? false
    }

    func saveDarkMode(isDarkMode: Bool) {
        appSettings?.isDarkMode = isDarkMode
    }

    func showUserAgreementView() {
        let params: AnalyticsEventParam = ["screen": "Settings", "item": "userAgreements"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        isShowUserAgreementView = true
    }
}
