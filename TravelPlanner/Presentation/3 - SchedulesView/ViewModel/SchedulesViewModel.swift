//
//  SchedulesViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import Foundation

@MainActor
final class SchedulesViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var stories = StoryFactory().stories
    @Published var fromStation = StationData.init(stationType: .fromStation)
    @Published var toStation = StationData.init(stationType: .toStation)
    @Published var isSelectionFromStationPresented: Bool = false
    @Published var isSelectionToStationPresented: Bool = false
    @Published var isFindSegmentsPresented: Bool = false

    // MARK: - Public Methods

    func changeStations() {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "changeStationsButton"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")

        let buffer = fromStation
        copyStationData(from: toStation, to: &fromStation)
        copyStationData(from: buffer, to: &toStation)
    }

    func selectStation(_ stationData: StationData) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "selectStationButton", "stationType": stationData.stationType.prompt]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        switch stationData.stationType {
        case .fromStation:
            isSelectionFromStationPresented = true
        case .toStation:
            isSelectionToStationPresented = true
        }
    }

    func findSegments() {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "findSegmentsButton"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        isFindSegmentsPresented = true
    }

    func loadStoriesIsViewedStatuses(from: [StoryViewStatus]) {
        from.forEach { storyData in
            if let storyIndex = stories.firstIndex(where: { $0.id == storyData.id }) {
                stories[storyIndex].isViewed = storyData.isViewed
            }
        }
    }

    // MARK: - Private Methods

    private func copyStationData(from source: StationData, to destination: inout StationData) {
        destination.city = source.city
        destination.station = source.station
    }
}
