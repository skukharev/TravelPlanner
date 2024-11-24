//
//  ViewModifier.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if !didLoad {
                didLoad = true
                action?()
            }
        }
    }
}
