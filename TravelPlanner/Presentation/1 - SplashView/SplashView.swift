//
//  SplashView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 28.10.2024.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Property Wrappers

    @State private var isShowSplashScreen = true

    // MARK: - Public Properties

    var body: some View {
        if isShowSplashScreen {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Image(asset: Asset.Images.splashView)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.isShowSplashScreen = false
                    }
                }
            }
        } else {
            MainView()
        }
    }
}

#Preview {
    SplashView()
}
