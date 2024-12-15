//
//  SplashView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 28.10.2024.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Property Wrappers

    @StateObject private var viewModel = SplashViewModel()

    // MARK: - Public Properties

    var body: some View {
        if viewModel.isShowSplashScreen {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Image(asset: Asset.Images.splashView)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        viewModel.isShowSplashScreen = false
                    }
                }
            }
        } else {
            MainView()
        }
    }
}

#Preview {
    let appSettings = AppSettings()
    SplashView()
        .environmentObject(appSettings)
}
