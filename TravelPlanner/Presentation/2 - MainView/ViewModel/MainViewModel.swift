//
//  MainViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 15.12.2024.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var selectedTab = 0
}
