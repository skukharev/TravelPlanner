//
//  CarrierPropertyView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 22.11.2024.
//

import SwiftUI

struct CarrierPropertyView: View {
    // MARK: - Types

    private enum Constants {
        static let rowHeight: CGFloat = 60
        static let propertiesVerticalSpacing: CGFloat = -2
        static let propertyNameFont: Font = GlobalConstants.ypRegular17
        static let propertyNameTextColor: Color = .appBlack
        static let propertyValueFont: Font = GlobalConstants.ypRegular12
        static let propertyValueTextColor: Color = .blueUniversal
    }

    // MARK: - Constants

    let propertyName: String
    let propertyValue: String

    // MARK: - Public Properties

    var body: some View {
        VStack(alignment: .leading, spacing: Constants.propertiesVerticalSpacing) {
            Text(propertyName)
                .font(Constants.propertyNameFont)
                .foregroundStyle(Constants.propertyNameTextColor)
            Text(propertyValue)
                .font(Constants.propertyValueFont)
                .foregroundStyle(Constants.propertyValueTextColor)
            HStack {
                Spacer()
            }
        }
        .frame(height: Constants.rowHeight)
    }
}

struct CarrierPropertyEmailPreview: View {
    let propertyName: String = "E-mail"
    let propertyValue: String = "i.lozgkina@yandex.ru"

    var body: some View {
        CarrierPropertyView(propertyName: propertyName, propertyValue: propertyValue)
    }
}

struct CarrierPropertyPhonePreview: View {
    let propertyName: String = "Телефон"
    let propertyValue: String = "+7 (495) 123-45-67"

    var body: some View {
        CarrierPropertyView(propertyName: propertyName, propertyValue: propertyValue)
    }
}

#Preview("E-mail") {
    CarrierPropertyEmailPreview()
}

#Preview("Phone") {
    CarrierPropertyPhonePreview()
}
