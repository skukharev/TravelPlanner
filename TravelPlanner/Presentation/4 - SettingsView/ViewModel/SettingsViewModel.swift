//
//  SettingsViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject {
    @Published var isDarkMode: Bool = false

    init() {}
}
