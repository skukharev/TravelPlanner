//
//  CarrierService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 17.10.2024.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrier(code: String) async throws -> Result<CarrierResponse, Error>
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCarrier(code: String) async throws -> Result<CarrierResponse, Error> {
        let response = try await client.getCarrier(
            query: .init(
                apikey: apikey,
                code: code
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
