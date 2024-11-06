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
}
