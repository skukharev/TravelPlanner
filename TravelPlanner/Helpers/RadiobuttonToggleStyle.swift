//
//  RadiobuttonToggleStyle.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import SwiftUI

struct RadionbuttonToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(asset: configuration.isOn ? Asset.Images.radiobuttonOn : Asset.Images.radiobuttonOff)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
