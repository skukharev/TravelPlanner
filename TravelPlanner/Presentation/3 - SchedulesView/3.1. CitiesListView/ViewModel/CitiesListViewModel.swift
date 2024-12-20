//
//  CitiesListViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.11.2024.
//

import Foundation
import OpenAPIURLSession

@MainActor
final class CitiesListViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isLoading: Bool = false
    @Published var isLoadingError: Bool = false
    @Published var filterText: String = ""
    @Published var isEmptyListPlaceholderHidden: Bool = true
    @Published var isSelectionStationLinkActivated: Bool = false
    @Published var selectedCity: City?
    var cities: [City] {
        if filterText.isEmpty {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !self.allCities.isEmpty
                }
            }
            return allCities
        } else {
            let filteredCitiesList = allCities.filter {
                $0.name.lowercased().contains(filterText.lowercased())
            }
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !filteredCitiesList.isEmpty
                }
            }
            return filteredCitiesList
        }
    }

    // MARK: - Private Properties

    private var allCities: [City] = []
    private let allowedStationTypes: [String] = ["train_station", "airport", "bus_station", "river_port", "marine_station", "station"]

    // MARK: - Public Methods

    func fetchCities() async throws {
        await MainActor.run {
            isLoading = true
            isLoadingError = false
        }
        var allSettlements: [City] = []
        do {
            let stationsList = try await stationsList()
            let russia = stationsList.countries?.first {
                $0.codes?.yandex_code == GlobalConstants.theRussianFederationId
            }
            russia?.regions?.compactMap { $0.settlements }.forEach { settlements in
                settlements.forEach { settlement in
                    if let id = settlement.codes?.yandex_code, let title = settlement.title {
                        var stations: [Station] = []
                        settlement.stations?.forEach { station in
                            if
                                let stationId = station.codes?.yandex_code,
                                let stationName = station.title,
                                allowedStationTypes.contains(where: { element in
                                    return element.lowercased() == station.station_type?.lowercased() ?? ""
                                }) {
                                stations.append(Station(id: stationId, name: stationName))
                            }
                        }
                        if !stations.isEmpty {
                            allSettlements.append(City(id: id, name: title, stations: stations))
                        }
                    }
                }
            }
            await MainActor.run { [allSettlements] in
                allCities = allSettlements
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                isLoadingError = true
            }
            return
        }
    }

    func selectCity(_ city: City) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "selectCityLink", "cityId": city.id, "cityName": city.name]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
    }

    // MARK: - Private Methods

    private func stationsList() async throws -> StationsListResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = StationsListService(client: client)
        return try await service.getStations()
    }
}
