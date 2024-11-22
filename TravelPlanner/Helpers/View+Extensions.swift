//
//  View+Extensions.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 06.11.2024.
//
import SwiftUI

extension View {
    @ViewBuilder
    func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }

    func navigationBarBackButtonTitleHidden() -> some View {
        self.modifier(BackButtonTitleHiddenModifier())
    }

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

struct BackButtonTitleHiddenModifier: ViewModifier {
    @Environment(\.dismiss)
    var dismiss

    @ViewBuilder
    @MainActor
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismissView) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                    }
                }
            }
    }

    private func dismissView() {
        dismiss()
    }
}
