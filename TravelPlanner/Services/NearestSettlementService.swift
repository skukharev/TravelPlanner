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
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlementResponse
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    private let client: Client

    init(client: Client) {
        self.client = client
    }

    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlementResponse {
        let response = try await client.getNearestSettlement(
            query: .init(
                lat: lat,
                lng: lng,
                distance: distance
            )
        )
        return try response.ok.body.json
    }
}
