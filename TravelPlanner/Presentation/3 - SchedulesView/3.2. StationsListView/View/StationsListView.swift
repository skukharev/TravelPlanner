//
//  StationsListView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 11.11.2024.
//

import SwiftUI

struct StationsListView: View {
    // MARK: - Types

    private enum Constants {
        static let searchStationPlaceholder = L10n.searchStationsPlaceholder
        static let searchStationNotFound = L10n.searchStationsNotFound
        static let searchStationNotFoundFont = GlobalConstants.ypBold24
        static let selectionStationTitle = L10n.selectionStationTitle
        static let defaultForegroundColor: Color = .appBlack
    }

    // MARK: - Public Properties

    @Binding var stationData: StationData
    @Binding var isShowRootLink: Bool
    @StateObject var viewModel = StationsListViewModel()
    var city: City?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            /// SearchBar
            HStack {
                HStack {
                    Image(systemName: GlobalConstants.searchBarMagnifyingGlassImageName)
                    TextField("", text: $viewModel.filterText, prompt: Text(Constants.searchStationPlaceholder))
                    Button(
                        action: { viewModel.filterText = "" },
                        label: {
                            Image(systemName: GlobalConstants.searchBarClearSearchTextImageName).opacity(viewModel.filterText.isEmpty ? 0 : 1)
                        }
                    )
                }
                .padding(GlobalConstants.searchBarPaddingInsets)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(GlobalConstants.searchBarCornerRadius)
            }
            .padding(.horizontal)
            /// Stations list
            ZStack {
                List(viewModel.stations) { station in
                    HStack {
                        Button(
                            action: { selectStation(station) },
                            label: { Text(station.name) }
                        )
                        Spacer()
                        Image(systemName: GlobalConstants.listNavigationLinkImageName)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                /// The Progress view displayed during the loading of the list of stations
                ProgressView()
                    .isHidden(!viewModel.isLoading)
                /// The stub displayed when the list of stations is empty
                Text(Constants.searchStationNotFound)
                    .isHidden(viewModel.isEmptyListPlaceholderHidden)
                    .font(Constants.searchStationNotFoundFont)
            }
        }
        .navigationTitle(Constants.selectionStationTitle)
        .navigationBarBackButtonTitleHidden()
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(Constants.defaultForegroundColor)
        .onAppear {
            if let city = city {
                viewModel.setup(withCity: city)
            }
        }
    }

    // MARK: - Private Methods

    private func selectStation(_ station: Station) {
        if let city = city {
            viewModel.selectStation(station: station, forCity: city, withStationData: &stationData)
        }
        isShowRootLink = false
    }
}

final class StationsListViewPreview: ObservableObject {
    @State var stationData = StationData(stationType: .fromStation)
    @State var isShowRootLink: Bool = true
    @State var city = City(id: "c35", name: "Краснодар", stations: [Station(id: "c54722", name: "Новая Уситва")])
}


#Preview {
    let params = StationsListViewPreview()
    StationsListView(
        stationData: params.$stationData,
        isShowRootLink: params.$isShowRootLink,
        city: params.city
    )
}
