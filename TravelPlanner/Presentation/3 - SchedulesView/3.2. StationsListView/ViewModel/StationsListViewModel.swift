//
//  StationsListViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 11.11.2024.
//

import Foundation

final class StationsListViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isLoading: Bool = false
    @Published var filterText: String = ""
    @Published var isEmptyListPlaceholderHidden: Bool = true
    var stations: [Station] {
        if filterText.isEmpty {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !self.allStations.isEmpty
                }
            }
            return allStations
        } else {
            let filteredStationsList = allStations.filter {
                $0.name.lowercased().contains(filterText.lowercased())
            }
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !filteredStationsList.isEmpty
                }
            }
            return filteredStationsList
        }
    }

    // MARK: - Private Properties

    private var allStations: [Station] = []

    // MARK: - Public Methods

    func setup(withCity city: City) {
        self.allStations = city.stations
    }

    func selectStation(station: Station, forCity city: City, withStationData stationData: inout StationData) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "selectStationLink", "stationId": station.id, "stationName": station.name]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")

        stationData.city = City(id: city.id, name: city.name)
        stationData.station = station
    }
}
