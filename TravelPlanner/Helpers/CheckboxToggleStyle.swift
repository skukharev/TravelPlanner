//
//  CheckboxToggleStyle.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 20.11.2024.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(asset: configuration.isOn ? Asset.Images.checkboxOn : Asset.Images.checkboxOff)
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
