//
//  SegmentView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 18.11.2024.
//

import SwiftUI

struct SegmentView: View {
    // MARK: - Types

    private enum Constants {
        static let segmentRowHeight: CGFloat = 104
        static let segmentRowBackground: Color = .lightGrayUniversal
        static let linesVerticalSpacing: CGFloat = 4
        static let firstLineHorizontalSpacing: CGFloat = 8
        static let firstLineTopPadding: CGFloat = 14
        static let carrierLogoCornerRadius: CGFloat = 12
        static let carrierLogoSize: CGFloat = 38
        static let carrierLogoLeadingSpacing: CGFloat = 14
        static let firstLineVerticalSpacing: CGFloat = 2
        static let carrierFont: Font = GlobalConstants.ypRegular17
        static let carrierTextColor: Color = .blackUniversal
        static let transfersFont: Font = GlobalConstants.ypRegular12
        static let transfersTextColor: Color = .redUniversal
        static let departureDayFont: Font = GlobalConstants.ypRegular12
        static let departureDayTextColor: Color = .blackUniversal
        static let departureDayTrailingSpacing: CGFloat = 7
        static let secondLineHorizontalSpacing: CGFloat = 4
        static let departureTimeFont: Font = GlobalConstants.ypRegular17
        static let departureTimeTextColor: Color = .blackUniversal
        static let departureTimeLeadingSpacing: CGFloat = 14
        static let secondLineHeight: CGFloat = 48
        static let durationTextPadding: CGFloat = 5
        static let durationLineWidth: CGFloat = 1
    }

    // MARK: - Public Properties

    var segment: Segment
    @StateObject var viewModel = SegmentViewModel()

    var body: some View {
        VStack(spacing: Constants.linesVerticalSpacing) {
            HStack(alignment: .center, spacing: Constants.firstLineHorizontalSpacing) {
                /// Carrier logo
                AsyncImage(url: viewModel.segment?.carrier.logo) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(RoundedRectangle(cornerRadius: Constants.carrierLogoCornerRadius))
                .frame(width: Constants.carrierLogoSize, height: Constants.carrierLogoSize)
                .scaledToFit()
                .padding(.leading, Constants.carrierLogoLeadingSpacing)
                /// Carrier name [with transfers]
                if viewModel.segment?.hasTransfers ?? false {
                    VStack(alignment: .leading, spacing: Constants.firstLineVerticalSpacing) {
                        Text(viewModel.segment?.carrier.title ?? "")
                            .foregroundStyle(Constants.carrierTextColor)
                            .font(Constants.carrierFont)
                            .lineLimit(1)
                        Text(viewModel.segment?.getTransferTitle() ?? "" )
                            .foregroundStyle(Constants.transfersTextColor)
                            .font(Constants.transfersFont)
                    }
                } else {
                    Text(viewModel.segment?.carrier.title ?? "")
                        .foregroundStyle(Constants.carrierTextColor)
                        .font(Constants.carrierFont)
                        .lineLimit(1)
                }
                Spacer()
                /// Departure day
                VStack(spacing: 0) {
                    Text(viewModel.segment?.getDepartureDay() ?? "")
                        .foregroundStyle(Constants.departureDayTextColor)
                        .font(Constants.departureDayFont)
                        .padding(.trailing, Constants.departureDayTrailingSpacing)
                    Spacer()
                }
                .frame(maxHeight: Constants.carrierLogoSize)
            }
            .frame(maxHeight: Constants.carrierLogoSize)
            .padding(.top, Constants.firstLineTopPadding)
            /// Segments timing
            HStack(spacing: Constants.secondLineHorizontalSpacing) {
                Text(viewModel.segment?.getDepartureTime() ?? "")
                    .foregroundStyle(Constants.departureTimeTextColor)
                    .font(Constants.departureTimeFont)
                    .padding(.leading, Constants.departureTimeLeadingSpacing)
                Rectangle()
                    .fill(.grayUniversal)
                    .frame(maxWidth: .infinity, maxHeight: Constants.durationLineWidth)
                Text(viewModel.segment?.getArrivalTime() ?? "")
                    .foregroundStyle(Constants.departureTimeTextColor)
                    .font(Constants.departureTimeFont)
                    .padding(.trailing, Constants.departureTimeLeadingSpacing)
            }
            .frame(height: Constants.secondLineHeight)
            .overlay(alignment: .center) {
                Text(viewModel.segment?.getSegmentDurationHours() ?? "")
                    .padding(.horizontal, Constants.durationTextPadding)
                    .background(.lightGrayUniversal)
            }
        }
        .frame(height: Constants.segmentRowHeight)
        .background(Constants.segmentRowBackground)
        .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
        .onTapGesture {
            viewModel.carrierDidSelect()
        }
        .onAppear {
            viewModel.setup(segment: segment)
        }
        .background {
            NavigationLink(
                destination: CarrierView(carrier: viewModel.segment?.carrier),
                isActive: $viewModel.isCarrierSelected
            ) {
                EmptyView()
            }
        }
    }
}

#Preview {
    let segment = Segment(
        departureDate: Date(),
        arrivalDate: Date(),
        hasTransfers: true,
        transferTitle: "Тула",
        carrier: Carrier(
            id: 112,
            title: "РЖД/ПФК",
            logo: URL(string: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif"),
            email: "info@rzd.ru",
            phone: "+7 (800) 775-00-00"
        )
    )
    SegmentView(segment: segment)
}
