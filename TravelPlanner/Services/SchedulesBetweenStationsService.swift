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
    func getSchedulesBetweenStations(fromStation: String, toStation: String) async throws -> Result<SchedulesBetweenStationsResponse, Error>
}

final class SchedulesBetweenStationService: SchedulesBetweenStationServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getSchedulesBetweenStations(fromStation: String, toStation: String) async throws -> Result<SchedulesBetweenStationsResponse, Error> {
        let response = try await client.getSchedulesBetweenStations(
            query: .init(
                apikey: apikey,
                from: fromStation,
                to: toStation
            )
        )
        switch response {
        case .ok:
            return try .success(response.ok.body.json)
        case .notFound:
            return try .failure(ObjectNotFoundError(response: response.notFound.body.json))
        case .undocumented(statusCode: _, let response):
            return .failure(ResponseOtherError(response: response.body.debugDescription))
        }
    }
}
