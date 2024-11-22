//
//  ShowTransfersToggleView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import SwiftUI

struct ShowTrasnfersToggleView: View {
    var title: String
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            Text(title)
        }
        .toggleStyle(RadionbuttonToggleStyle())
    }
}
