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

    // MARK: - Public Properties

    @Binding var stationData: StationData
    @Binding var isShowRootLink: Bool
    @StateObject var viewModel = CitiesListViewModel()
    @State var selectedCity: City?
    @State var isSelectionStationLinkActivated: Bool = false

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
                                Image(systemName: GlobalConstants.searchBarClearSearchTextImageName).opacity(viewModel.filterText.isEmpty ? 0 : 1)
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
                    .background(
                        NavigationLink(
                            destination: StationsListView(
                                stationData: $stationData,
                                isShowRootLink: $isShowRootLink,
                                city: selectedCity
                            ),
                            isActive: $isSelectionStationLinkActivated
                        ) {
                            EmptyView()
                        }
                    )
                    .listStyle(.plain)
                    /// The Progress view displayed during the loading of the list of cities
                    ProgressView()
                        .isHidden(!viewModel.isLoading)
                    /// The stub displayed when the list of cities is empty
                    Text(Constants.searchCityNotFound)
                        .isHidden(viewModel.isEmptyListPlaceholderHidden)
                        .font(Constants.searchCityNotFoundFont)
                }
            }
            .isHidden(viewModel.isLoadingError)
            ErrorView(errorType: .noInternetError)
                .isHidden(!viewModel.isLoadingError)
        }
        .navigationTitle(Constants.selectionCityTitle)
        .navigationBarBackButtonTitleHidden()
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(Constants.defaultForegroundColor)
        .onAppear {
            Task {
                try await viewModel.fetchCities()
            }
        }
    }

    // MARK: - Private Methods

    private func selectCity(_ city: City) {
        viewModel.selectCity(city)
        selectedCity = city
        isSelectionStationLinkActivated = true
    }
}

final class CitiesListViewPreview: ObservableObject {
    @State var stationData = StationData(stationType: .fromStation)
    @State var isShowRootLink: Bool = true
}

#Preview {
    let params = CitiesListViewPreview()
    CitiesListView(stationData: params.$stationData, isShowRootLink: params.$isShowRootLink)
}
