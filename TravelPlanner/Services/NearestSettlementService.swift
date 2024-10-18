//
//  NearestSettlementService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlementResponse = Components.Schemas.NearestSettlementResponse

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Result<NearestSettlementResponse, Error>
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> Result<NearestSettlementResponse, Error> {
        let response = try await client.getNearestSettlement(
            query: .init(
                apikey: apikey,
                lat: lat,
                lng: lng,
                distance: distance
            )
        )
        switch response {
        case .ok:
            return .success(try response.ok.body.json)
        case .notFound:
            return .failure(try ObjectNotFoundError(response: response.notFound.body.json))
        case .undocumented(statusCode: _, let response):
            return .failure(ResponseOtherError(response: response.body.debugDescription))
        }
    }
}
