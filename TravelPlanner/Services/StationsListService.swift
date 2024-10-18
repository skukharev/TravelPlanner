//
//  StationsService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsListResponse = Components.Schemas.StationsListResponse

protocol StationsListServiceProtocol {
    func getStations() async throws -> Result<StationsListResponse, Error>
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStations() async throws -> Result<StationsListResponse, Error> {
        let response = try await client.getStations(
            query: .init(
                apikey: apikey
            )
        )

        switch response {
        case .ok:
            return try .success(response.ok.body.json)
        case .undocumented(statusCode: _, let response):
            return .failure(ResponseOtherError(response: response.body.debugDescription))
        }
    }
}
