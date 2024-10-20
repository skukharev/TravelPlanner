//
//  StationsService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsListResponse = Components.Schemas.StationsListResponse

protocol StationsListServiceProtocol {
    func getStations() async throws -> StationsListResponse
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getStations() async throws -> StationsListResponse {
        let response = try await client.getStations(query: .init())
        let httpBody = try response.ok.body.html
        return try await JSONDecoder().decode(from: httpBody, to: StationsListResponse.self)
    }
}
