//
//  StationScheduleService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationScheduleResponse = Components.Schemas.StationScheduleResponse

protocol StationScheduleServiceProtocol {
    func getStationSchedule(forStation: String) async throws -> StationScheduleResponse
}

actor StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getStationSchedule(forStation: String) async throws -> StationScheduleResponse {
        let response = try await client.getStationSchedule(
            query: .init(
                station: forStation
            )
        )
        return try response.ok.body.json
    }
}
