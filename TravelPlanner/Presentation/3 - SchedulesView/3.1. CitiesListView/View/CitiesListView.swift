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
        static let searchBarMagnifyingGlassImageName = "magnifyingglass"
        static let searchBarClearSearchTextImageName = "xmark.circle.fill"
        static let searchBarCornerRadius: CGFloat = 10.0
        static let searchBarPaddingInsets = EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
    }

    // MARK: - Public Properties

    @Binding var station: Station
    @Binding var isShowRootLink: Bool
    @StateObject var viewModel = CitiesListViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            /// SearchBar
            HStack {
                HStack {
                    Image(systemName: Constants.searchBarMagnifyingGlassImageName)
                    TextField("", text: $viewModel.filterText, prompt: Text(Constants.searchCityPlaceholder))
                    Button(
                        action: { viewModel.filterText = "" },
                        label: {
                            Image(systemName:  Constants.searchBarClearSearchTextImageName).opacity(viewModel.filterText.isEmpty ? 0 : 1)
                        }
                    )
                }
                .padding(Constants.searchBarPaddingInsets)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(Constants.searchBarCornerRadius)
            }
            .padding(.horizontal)
            /// Cities list
            ZStack {
                List(viewModel.cities) { city in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Text(city.name)
                    }
                    .listRowSeparator(.hidden)
                }
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
}

final class CitiesListViewPreview: ObservableObject {
    @State var station = Station(stationType: .fromStation)
    @State var isShowRootLink: Bool = true
}

#Preview {
    let params = CitiesListViewPreview()
    CitiesListView(station: params.$station, isShowRootLink: params.$isShowRootLink)
}
