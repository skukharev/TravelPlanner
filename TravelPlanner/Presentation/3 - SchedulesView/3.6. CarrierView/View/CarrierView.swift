//
//  CarrierView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 21.11.2024.
//

import SwiftUI

struct CarrierView: View {
    // MARK: - Types

    private enum Constants {
        static let defaultForegroundColor: Color = .appBlack
        static let carrierNavigationTitle = L10n.carrierNavigationTitle
        static let carrierLogoHeight: CGFloat = 104
        static let defaultElementsSpacing: CGFloat = 16
        static let carrierNameFont: Font = GlobalConstants.ypBold24
        static let emailPropertyName = L10n.emailCarrierPropertyName
        static let phonePropertyName = L10n.phoneCarrierPropertyName
    }

    // MARK: - Public Properties

    var carrier: Carrier?

    var body: some View {
        VStack(alignment: .center, spacing: Constants.defaultElementsSpacing) {
            /// Carrier logo
            AsyncImage(url: carrier?.logo) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: Constants.carrierLogoHeight)
            .scaledToFit()
            /// Carrier info panel
            HStack {
                Text(carrier?.title ?? "")
                    .font(Constants.carrierNameFont)
                    .foregroundStyle(Constants.defaultForegroundColor)
                Spacer()
            }
            List {
                CarrierPropertyView(
                    propertyName: Constants.emailPropertyName,
                    propertyValue: carrier?.email ?? ""
                )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                CarrierPropertyView(
                    propertyName: Constants.phonePropertyName,
                    propertyValue: carrier?.phone ?? ""
                )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            Spacer()
        }
        .padding()
        .navigationBarBackButtonTitleHidden()
        .foregroundStyle(Constants.defaultForegroundColor)
        .navigationTitle(Constants.carrierNavigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CarrierPreview: View {
    @State var carrier = Carrier(
        id: 112,
        title: "РЖД/ПФК",
        logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif"),
        email: "info@rzd.ru",
        phone: "+7 (800) 775-00-00"
    )
    var body: some View {
        NavigationView {
            CarrierView(carrier: carrier)
        }
    }
}

#Preview {
    CarrierPreview()
}
