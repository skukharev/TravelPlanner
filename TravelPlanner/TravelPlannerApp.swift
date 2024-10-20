//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 03.10.2024.
//

import SwiftUI
import OpenAPIURLSession

@main
struct TravelPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        AnalyticsService.activate()
    }

    func schedulesBetweenStations(fromStation: String, toStation: String) async throws -> SchedulesBetweenStationsResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = SchedulesBetweenStationService(client: client)
        return try await service.getSchedulesBetweenStations(fromStation: fromStation, toStation: toStation)
    }

    func stationSchedule(forStation: String) async throws -> StationScheduleResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = StationScheduleService(client: client)
        return try await service.getStationSchedule(forStation: forStation)
    }

    func threadStations(forUID: String) async throws -> ThreadResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = ThreadStationsService(client: client)
        return try await service.getThreadStations(forUID: forUID)
    }

    func nearestStations(latitude: Double, longitude: Double, distance: Int) async throws -> NearestStationsResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = NearestStationsService(client: client)
        return try await service.getNearestStations(lat: latitude, lng: longitude, distance: distance)
    }

    func nearestSettlements(latitude: Double, longitude: Double, distance: Int) async throws -> NearestSettlementResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = NearestSettlementService(client: client)
        return try await service.getNearestSettlement(lat: latitude, lng: longitude, distance: distance)
    }

    func carrier(forCode: String) async throws -> CarrierResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CarrierService(client: client)
        return try await service.getCarrier(code: forCode)
    }

    func stationsList() async throws -> StationsListResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = StationsListService(client: client)
        return try await service.getStations()
    }

    func copyright() async throws -> CopyrightResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CopyrightService(client: client)
        return try await service.getCopyright()
    }
}
