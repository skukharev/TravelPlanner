//
//  ThreadsView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 13.11.2024.
//

import SwiftUI

struct SegmentsView: View {
    // MARK: - Types

    private enum Constants {
        static let defaultForegroundColor: Color = .appBlack
        static let defaultVerticalSpacing = GlobalConstants.defaultVerticalSpacing
        static let titleFont = GlobalConstants.ypBold24
        static let segmentsParametersButtonTitle = L10n.findSegmentsButtonTitle
        static let segmentsParametersButtonHeight: CGFloat = 60
        static let segmentsParametersButtonFont = GlobalConstants.ypBold17
        static let segmentsParametersButtonBackgroundColor: Color = .blueUniversal
        static let segmentsParametersButtonTextColor: Color = .white
    }

    // MARK: - Public Properties

    @Binding var fromStation: StationData
    @Binding var toStation: StationData
    @StateObject var viewModel = SegmentsViewModel()

    var body: some View {
        VStack(spacing: Constants.defaultVerticalSpacing) {
            Text(viewModel.navigationTitle)
                .font(Constants.titleFont)
                .foregroundStyle(.appBlack)
            List(viewModel.segments) { segment in
                SegmentView(segment: segment)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .bottom) {
                Button(
                    action: {
                        paramsButtonTap()
                    },
                    label: {
                        Text(L10n.segmentParametersButtonTitle)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: Constants.segmentsParametersButtonHeight
                            )
                            .font(Constants.segmentsParametersButtonFont)
                    }
                )
                .background(Constants.segmentsParametersButtonBackgroundColor)
                .foregroundStyle(Constants.segmentsParametersButtonTextColor)
                .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonTitleHidden()
        .foregroundStyle(Constants.defaultForegroundColor)
        .onAppear {
            viewModel.setup(fromStation: fromStation, toStation: toStation)
        }
    }

    // MARK: - Private Methods

    private func paramsButtonTap() {
        
    }
}

private struct SegmentsViewPreview: View {
    @State var fromStation = StationData(
        stationType: .fromStation,
        city: City(id: "c1000001", name: "Москва"),
        station: Station(id: "s2000001", name: "Курский вокзал")
    )
    @State var toStation = StationData(
        stationType: .toStation,
        city: City(id: "c1000002", name: "Краснодар"),
        station: Station(id: "s9613602", name: "Краснодар-1")
    )

    var body: some View {
        SegmentsView(fromStation: $fromStation, toStation: $toStation)
    }
}

#Preview {
    SegmentsViewPreview()
}
