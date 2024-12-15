//
//  ThreadStationsService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadResponse = Components.Schemas.ThreadResponse

protocol ThreadStationsServiceProtocol {
    func getThreadStations(forUID: String) async throws -> ThreadResponse
}

actor ThreadStationsService: ThreadStationsServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getThreadStations(forUID: String) async throws -> ThreadResponse {
        let response = try await client.getThreadStations(
            query: .init(
                uid: forUID,
                show_systems: Operations.getThreadStations.Input.Query.show_systemsPayload.yandex
            )
        )
        return try response.ok.body.json
    }
}
