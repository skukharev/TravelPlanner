//
//  SchedulesView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 30.10.2024.
//

import SwiftUI

struct SchedulesView: View {
    // MARK: - Types

    private enum Constants {
        static let storiesSpacing: CGFloat = 12
        static let storiesHeight: CGFloat = 188
        static let stationsBackgroundHeight: CGFloat = 128
        static let stationsBackgroundColor: Color = .blueUniversal
        static let stationsElementsSpacing: CGFloat = 0
        static let stationsElementsHeight: CGFloat = 96
        static let stationsElementsBackgroundColor: Color = .white
        static let stationsElementsEmptyTextColor: Color = .grayUniversal
        static let stationsElementsDefinedTextColor: Color = .black
        static let changeStationsButtonWidth: CGFloat = 36
        static let changeStationsButtonColor: Color = .white
        static let changeStationsButtonCornerRadius: CGFloat = 40
        static let findSegmentsButtonTitle = L10n.findSegmentsButtonTitle
        static let findSegmentsButtonWidth: CGFloat = 150
        static let findSegmentsButtonHeight: CGFloat = 60
        static let findSegmentsButtonFont = GlobalConstants.ypBold17
        static let findSegmentsButtonBackgroundColor: Color = .blueUniversal
        static let findSegmentsButtonTextColor: Color = .white
        static let defaultVerticalSpacing: CGFloat = GlobalConstants.defaultVerticalSpacing
    }

    // MARK: - Constants

    let rows = [GridItem(.flexible())]
    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Property Wrappers

    @StateObject private var viewModel = SchedulesViewModel()
    @StateObject private var nav = NavigationStateManager()

    // MARK: - Public Properties

    var body: some View {
        VStack(spacing: Constants.defaultVerticalSpacing) {
            /// Stories
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center, spacing: Constants.storiesSpacing) {
                    ForEach($viewModel.stories) { $story in
                        StoriesRowView(stories: $viewModel.stories, story: $story)
                    }
                }
                .frame(maxHeight: Constants.storiesHeight)
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal)
            /// Stations selection controls
            ZStack {
                RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius)
                    .fill(Constants.stationsBackgroundColor)
                    .frame(height: Constants.stationsBackgroundHeight)
                    .padding(.horizontal)
                HStack {
                    HStack(spacing: Constants.stationsElementsSpacing) {
                        List {
                            Group {
                                /// From station
                                Button(
                                    action: { stationSelectionTap(viewModel.fromStation) },
                                    label: { Text(viewModel.fromStation.stationTitle).lineLimit(1) }
                                )
                                .foregroundStyle(viewModel.fromStation.isEmpty ? Constants.stationsElementsEmptyTextColor : Constants.stationsElementsDefinedTextColor)
                                .fullScreenCover(isPresented: $viewModel.isSelectionFromStationPresented) {
                                    NavigationStack {
                                        NavigationLink("", value: "CitiesListView")
                                            .navigationDestination(isPresented: $viewModel.isSelectionFromStationPresented) {
                                                CitiesListView(
                                                    stationData: $viewModel.fromStation,
                                                    isShowRootLink: $viewModel.isSelectionFromStationPresented
                                                )
                                            }
                                    }
                                }
                                /// To station
                                Button(
                                    action: { stationSelectionTap(viewModel.toStation) },
                                    label: { Text(viewModel.toStation.stationTitle).lineLimit(1) }
                                )
                                .foregroundStyle(viewModel.toStation.isEmpty ? Constants.stationsElementsEmptyTextColor : Constants.stationsElementsDefinedTextColor)
                                .fullScreenCover(isPresented: $viewModel.isSelectionToStationPresented) {
                                    NavigationView {
                                        NavigationStack {
                                            NavigationLink("", value: "CitiesListView")
                                                .navigationDestination(isPresented: $viewModel.isSelectionToStationPresented) {
                                                    CitiesListView(
                                                        stationData: $viewModel.toStation,
                                                        isShowRootLink: $viewModel.isSelectionToStationPresented
                                                    )
                                                }
                                        }
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Rectangle().fill(Constants.stationsElementsBackgroundColor))
                            .tint(.appBlack)
                        }
                        .background(Constants.stationsElementsBackgroundColor)
                        .listStyle(.plain)
                        .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
                        /// Change stations button
                        Button(action: changeStationsButtonTap) {
                            Image(asset: Asset.Images.changeStationButton)
                        }
                        .frame(
                            width: Constants.changeStationsButtonWidth,
                            height: Constants.changeStationsButtonWidth
                        )
                        .background(Constants.changeStationsButtonColor)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.changeStationsButtonCornerRadius))
                        .padding(.leading)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: Constants.stationsElementsHeight)
                }
                .padding(.horizontal)
            }
            /// Find segments button
            Button(
                action: {
                    findSegmentsButtonTap()
                },
                label: {
                    Text(Constants.findSegmentsButtonTitle)
                        .frame(
                            minWidth: Constants.findSegmentsButtonWidth,
                            minHeight: Constants.findSegmentsButtonHeight
                        )
                        .font(Constants.findSegmentsButtonFont)
                }
            )
            .background(Constants.findSegmentsButtonBackgroundColor)
            .foregroundStyle(Constants.findSegmentsButtonTextColor)
            .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))
            .opacity(viewModel.fromStation.isEmpty || viewModel.toStation.isEmpty ? 0 : 1)
            .fullScreenCover(isPresented: $viewModel.isFindSegmentsPresented) {
                NavigationStack(path: $nav.path) {
                    SegmentsView(fromStation: $viewModel.fromStation, toStation: $viewModel.toStation)
                }
                .environmentObject(nav)
            }

            Spacer()

            Divider()
        }
    }

    // MARK: - Private Methods

    private func changeStationsButtonTap() {
        viewModel.changeStations()
    }

    private func stationSelectionTap(_ stationData: StationData) {
        impactMed.impactOccurred()
        viewModel.selectStation(stationData)
    }

    private func findSegmentsButtonTap() {
        impactMed.impactOccurred()
        viewModel.findSegments()
    }
}

#Preview {
    SchedulesView()
}
