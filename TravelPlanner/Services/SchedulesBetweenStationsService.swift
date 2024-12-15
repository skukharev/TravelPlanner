//
//  SchedulesBetweenStationsService.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.10.2024.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias SchedulesBetweenStationsResponse = Components.Schemas.SchedulesBetweenStationsResponse

protocol SchedulesBetweenStationServiceProtocol {
    func getSchedulesBetweenStations(fromStation: String, toStation: String, date: Date, transfers: Bool) async throws -> SchedulesBetweenStationsResponse
}

actor SchedulesBetweenStationService: SchedulesBetweenStationServiceProtocol {
    private let client: Client
    private var dateFormatter = DateFormatter()

    init(client: Client) {
        self.client = client
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
    }

    func getSchedulesBetweenStations(fromStation: String, toStation: String, date: Date, transfers: Bool) async throws -> SchedulesBetweenStationsResponse {
        let dateParam = dateFormatter.string(from: date)

        let response = try await client.getSchedulesBetweenStations(
            query: .init(
                from: fromStation,
                to: toStation,
                date: dateParam,
                transfers: transfers
            )
        )
        switch response {
        case .ok(let okResponse):
            return try okResponse.body.json
        default:
            throw ErrorViewType.serverError
        }
    }
}
