//
//  CloseButton.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 10.12.2024.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: {
                action()
            },
            label: {
                Image(asset: Asset.Images.closeButton)
            }
        )
    }
}

#Preview {
    CloseButton {
        print("Close button pressed")
    }
}
