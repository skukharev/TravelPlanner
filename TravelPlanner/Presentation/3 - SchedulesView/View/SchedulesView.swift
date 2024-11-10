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
        static let stationsElementsTextColor: Color = .grayUniversal
        static let changeStationsButtonWidth: CGFloat = 36
        static let changeStationsButtonColor: Color = .white
        static let changeStationsButtonCornerRadius: CGFloat = 40
    }

    // MARK: - Constants

    let rows = [GridItem(.flexible())]
    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Public Properties

    @StateObject var viewModel = SchedulesViewModel()

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center, spacing: Constants.storiesSpacing) {
                    ForEach(viewModel.stories) { story in
                        StoriesRowView(story: story)
                    }
                }
                .frame(maxHeight: Constants.storiesHeight)
            }
            .padding()
            ZStack {
                RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius)
                    .fill(Constants.stationsBackgroundColor)
                    .frame(height: Constants.stationsBackgroundHeight)
                    .padding(.horizontal)
                HStack {
                    HStack(spacing: Constants.stationsElementsSpacing) {
                        List {
                            Group {
                                Button(
                                    action: { stationSelectionTap(viewModel.fromStation) },
                                    label: { Text(viewModel.fromStation.stationTitle) }
                                )
                                .fullScreenCover(isPresented: $viewModel.isSelectionFromStationPresented) {
                                    NavigationView {
                                        NavigationLink(
                                            destination: CitiesListView(
                                                station: $viewModel.fromStation,
                                                isShowRootLink: $viewModel.isSelectionFromStationPresented
                                            ),
                                            isActive: $viewModel.isSelectionFromStationPresented
                                        ) {
                                            EmptyView()
                                        }
                                    }
                                }
                                Button(
                                    action: { stationSelectionTap(viewModel.toStation) },
                                    label: { Text(viewModel.toStation.stationTitle) }
                                )
                                .fullScreenCover(isPresented: $viewModel.isSelectionToStationPresented) {
                                    NavigationView {
                                        NavigationView {
                                            NavigationLink(
                                                destination: CitiesListView(
                                                    station: $viewModel.toStation,
                                                    isShowRootLink: $viewModel.isSelectionToStationPresented
                                                ),
                                                isActive: $viewModel.isSelectionToStationPresented
                                            ) {
                                                EmptyView()
                                            }
                                        }
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Rectangle().fill(Constants.stationsElementsBackgroundColor))
                            .tint(.appBlack)
                        }
                        .foregroundStyle(Constants.stationsElementsTextColor)
                        .background(Constants.stationsElementsBackgroundColor)
                        .listStyle(.plain)
                        .clipShape(RoundedRectangle(cornerRadius: GlobalConstants.defaultCornerRadius))

                        Button(action: changeStationsButtonTap) {
                            Image(asset: Asset.Images.changeStationButton)
                        }
                        .frame(width: Constants.changeStationsButtonWidth, height: Constants.changeStationsButtonWidth)
                        .background(Constants.changeStationsButtonColor)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.changeStationsButtonCornerRadius))
                        .padding(.leading)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: Constants.stationsElementsHeight)
                }
                .padding(.horizontal)
            }
            Spacer()
            Divider()
        }
    }

    // MARK: - Public Methods

    private func changeStationsButtonTap() {
        viewModel.changeStations()
    }

    private func stationSelectionTap(_ station: Station) {
        impactMed.impactOccurred()
        viewModel.selectStation(station)
    }
}

#Preview {
    SchedulesView()
}
