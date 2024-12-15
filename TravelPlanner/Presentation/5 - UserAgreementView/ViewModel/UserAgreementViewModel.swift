//
//  UserAgreementViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 15.12.2024.
//

import Foundation

@MainActor
final class UserAgreementViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isLoading = true
    @Published var loadingProgress: Double = 0.0
    @Published var isLoadingError = false

    // MARK: - Public Methods

    func initialize() {
        isLoading = true
        loadingProgress = 0.0
        isLoadingError = false
    }
}
