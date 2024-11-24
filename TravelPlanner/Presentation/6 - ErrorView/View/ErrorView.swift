//
//  ErrorView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 23.11.2024.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - Constants

    enum Constants {
        static let imageWidth: CGFloat = 223
        static let imageCorenerRadius: CGFloat = 70
        static let errorDescriptionFont: Font = GlobalConstants.ypBold24
        static let errorDescriptionTextColor: Color = .appBlack
        static let defaultElementsSpacing: CGFloat = 16
    }

    // MARK: - Public Properties

    var errorType: ErrorViewType?

    var body: some View {
        VStack(spacing: Constants.defaultElementsSpacing) {
            Image(asset: errorType?.imageAsset() ?? Asset.Images.serverError)
                .resizable()
                .scaledToFit()
                .frame(
                    width: Constants.imageWidth,
                    height: Constants.imageWidth,
                    alignment: .center
                )
                .clipShape(RoundedRectangle(cornerRadius: Constants.imageCorenerRadius))
            Text(errorType?.errorDescription() ?? "")
                .font(Constants.errorDescriptionFont)
                .foregroundStyle(Constants.errorDescriptionTextColor)
        }
    }
}

#Preview("No internet") {
    ErrorView(errorType: .noInternetError)
}

#Preview("Server error") {
    ErrorView(errorType: .serverError)
}
