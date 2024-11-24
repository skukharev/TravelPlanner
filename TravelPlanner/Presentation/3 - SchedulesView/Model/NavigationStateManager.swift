//
//  NavigationStateManager.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 24.11.2024.
//

import SwiftUI

class NavigationStateManager: ObservableObject {
    @Published var path = NavigationPath()
}
