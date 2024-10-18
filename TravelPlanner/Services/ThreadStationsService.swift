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
    func getThreadStations(forUID: String) async throws -> Result<ThreadResponse, Error>
}

final class ThreadStationsService: ThreadStationsServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getThreadStations(forUID: String) async throws -> Result<ThreadResponse, Error> {
        let response = try await client.getThreadStations(
            query: .init(
                apikey: apikey,
                uid: forUID,
                show_systems: Operations.getThreadStations.Input.Query.show_systemsPayload.yandex
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
