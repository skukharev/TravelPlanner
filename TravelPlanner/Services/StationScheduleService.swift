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
    func getStationSchedule(forStation: String) async throws -> Result<StationScheduleResponse, Error>
}

final class StationScheduleService: StationScheduleServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationSchedule(forStation: String) async throws -> Result<StationScheduleResponse, Error> {
        let response = try await client.getStationSchedule(
            query: .init(
                apikey: apikey,
                station: forStation
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
