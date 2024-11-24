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
        static let segmentsParametersButtonTitle = L10n.segmentParametersButtonTitle
        static let segmentsParametersButtonHeight: CGFloat = 60
        static let segmentsParametersButtonFont = GlobalConstants.ypBold17
        static let segmentsParametersButtonBackgroundColor: Color = .blueUniversal
        static let segmentsParametersButtonTextColor: Color = .white
        static let segmentsNotFoundText = L10n.segmentsNotFound
        static let segmentsNotFoundFont = GlobalConstants.ypBold24
    }

    // MARK: - Constants

    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Public Properties

    @Binding var fromStation: StationData
    @Binding var toStation: StationData

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: Constants.defaultVerticalSpacing) {
                Text(viewModel.navigationTitle)
                    .font(Constants.titleFont)
                    .foregroundStyle(.appBlack)
                    .padding(.horizontal)
                List(viewModel.segments) { segment in
                    SegmentView(segment: segment)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationDestination(for: Carrier.self) { carrier in
                    CarrierView(carrier: carrier)
                }
                .safeAreaInset(edge: .bottom) {
                    Button(
                        action: {
                            paramsButtonTap()
                        },
                        label: {
                            HStack {
                                Text(Constants.segmentsParametersButtonTitle)
                                Image(asset: Asset.Images.redMarker)
                                    .opacity(viewModel.segmentsParams.isEmpty ? 0 : 1)
                            }
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
                    .navigationDestination(isPresented: $viewModel.isSegmentParamsPresented) {
                        SegmentParamsView(params: $viewModel.segmentsParams)
                    }
                }
            }
            .opacity(viewModel.loadingError != nil ? 0 : 1)
            /// The Progress view displayed during the loading of the list of segments
            ProgressView()
                .opacity(viewModel.isLoading ? 1 : 0)
            /// The stub displayed when the list of segments is empty
            Text(Constants.segmentsNotFoundText)
                .opacity(viewModel.isEmptyListPlaceholderHidden ? 0 : 1)
                .font(Constants.segmentsNotFoundFont)
            ErrorView(errorType: viewModel.loadingError)
                .opacity(viewModel.loadingError == nil ? 0 : 1)
        }
        .navigationBarBackButtonTitleHidden()
        .foregroundStyle(Constants.defaultForegroundColor)
        .onLoad {
            viewModel.setup(fromStation: fromStation, toStation: toStation)
        }
    }

    // MARK: - Private Properties

    @StateObject private var viewModel = SegmentsViewModel()

    // MARK: - Private Methods

    private func paramsButtonTap() {
        impactMed.impactOccurred()
        viewModel.showSegmentParams()
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
    @StateObject private var nav = NavigationStateManager()

    var body: some View {
        NavigationStack(path: $nav.path) {
            SegmentsView(fromStation: $fromStation, toStation: $toStation)
        }
        .navigationDestination(for: Carrier.self) { carrier in
            CarrierView(carrier: carrier)
        }
        .environmentObject(nav)
    }
}

#Preview {
    SegmentsViewPreview()
}
