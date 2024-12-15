//
//  ContentView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 03.10.2024.
//

import SwiftUI

struct MainView: View {
    // MARK: - Property Wrappers

    @StateObject private var viewModel = MainViewModel()

    // MARK: - Public Properties

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            SchedulesView()
                .tabItem {
                    Image(Asset.Images.scheduleTabItem.name)
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    Image(Asset.Images.settingsTabItem.name)
                }
                .tag(1)
        }
        .accentColor(Asset.Colors.activeTabItemColor.swiftUIColor)
    }
}

#Preview {
    let appSettings = AppSettings()
    MainView()
        .environmentObject(appSettings)
}
