//
//  SchedulesBetweenStationsService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SchedulesBetweenStationsResponse = Components.Schemas.SchedulesBetweenStationsResponse

protocol SchedulesBetweenStationServiceProtocol {
    func getSchedulesBetweenStations(fromStation: String, toStation: String) async throws -> SchedulesBetweenStationsResponse
}

final class SchedulesBetweenStationService: SchedulesBetweenStationServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getSchedulesBetweenStations(fromStation: String, toStation: String) async throws -> SchedulesBetweenStationsResponse {
        let response = try await client.getSchedulesBetweenStations(
            query: .init(
                from: fromStation,
                to: toStation
            )
        )
        return try response.ok.body.json
    }
}
