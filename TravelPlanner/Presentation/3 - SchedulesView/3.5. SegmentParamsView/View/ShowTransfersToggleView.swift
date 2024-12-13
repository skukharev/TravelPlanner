//
//  ShowTransfersToggleView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import SwiftUI

struct ShowTrasnfersToggleView: View {
    // MARK: - Property Wrappers

    @Binding var isOn: Bool

    // MARK: - Public Properties

    var title: String
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
        .toggleStyle(RadionbuttonToggleStyle())
        .tint(.appBlack)
    }
}
