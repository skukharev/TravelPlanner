//
//  CitiesListView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 08.11.2024.
//

import SwiftUI

struct CitiesListView: View {
    // MARK: - Types

    private enum Constants {
        static let searchCityPlaceholder = L10n.searchCityPlaceholder
        static let searchCityNotFound = L10n.searchCityNotFound
        static let selectionCityTitle = L10n.selectionCityTitle
        static let searchCityNotFoundFont = GlobalConstants.ypBold24
        static let defaultForegroundColor: Color = .appBlack
    }

    // MARK: - Property Wrappers

    @Binding var stationData: StationData
    @Binding var isShowRootLink: Bool
    @StateObject private var viewModel = CitiesListViewModel()

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                /// SearchBar
                HStack {
                    HStack {
                        Image(systemName: GlobalConstants.searchBarMagnifyingGlassImageName)
                        TextField("", text: $viewModel.filterText, prompt: Text(Constants.searchCityPlaceholder))
                        Button(
                            action: { viewModel.filterText = "" },
                            label: {
                                Image(systemName: GlobalConstants.searchBarClearSearchTextImageName)
                                    .opacity(viewModel.filterText.isEmpty ? 0 : 1)
                            }
                        )
                    }
                    .padding(GlobalConstants.searchBarPaddingInsets)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(GlobalConstants.searchBarCornerRadius)
                }
                .padding(.horizontal)
                /// Cities list
                ZStack {
                    List(viewModel.cities) { city in
                        HStack {
                            Button(
                                action: { selectCity(city) },
                                label: { Text(city.name) }
                            )
                            Spacer()
                            Image(systemName: GlobalConstants.listNavigationLinkImageName)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .navigationDestination(isPresented: $viewModel.isSelectionStationLinkActivated) {
                        StationsListView(
                            stationData: $stationData,
                            isShowRootLink: $isShowRootLink,
                            city: $viewModel.selectedCity
                        )
                    }
                    /// The Progress view displayed during the loading of the list of cities
                    ProgressView()
                        .opacity(viewModel.isLoading ? 1 : 0)
                    /// The stub displayed when the list of cities is empty
                    Text(Constants.searchCityNotFound)
                        .opacity(viewModel.isEmptyListPlaceholderHidden ? 0 : 1)
                        .font(Constants.searchCityNotFoundFont)
                }
            }
            .opacity(viewModel.isLoadingError ? 0 : 1)
            ErrorView(errorType: .noInternetError)
                .opacity(viewModel.isLoadingError ? 1 : 0)
        }
        .navigationTitle(Constants.selectionCityTitle)
        .navigationBarBackButtonTitleHidden()
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(Constants.defaultForegroundColor)
        .task {
            try? await viewModel.fetchCities()
        }
    }

    // MARK: - Private Methods

    private func selectCity(_ city: City) {
        viewModel.selectCity(city)
        viewModel.selectedCity = city
        viewModel.isSelectionStationLinkActivated = true
    }
}

struct CitiesListViewPreview: View {
    @State var stationData = StationData(stationType: .fromStation)
    @State var isShowRootLink: Bool = true

    var body: some View {
        NavigationStack {
            CitiesListView(stationData: $stationData, isShowRootLink: $isShowRootLink)
        }
    }
}

#Preview {
    CitiesListViewPreview()
}
