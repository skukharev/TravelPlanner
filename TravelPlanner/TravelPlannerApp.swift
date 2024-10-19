//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 03.10.2024.
//

import SwiftUI
import OpenAPIURLSession

@main
struct TravelPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        AnalyticsService.activate()
    }

    func schedulesBetweenStations(fromStation: String, toStation: String, completion: ((Result<SchedulesBetweenStationsResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = SchedulesBetweenStationService(client: client)

        Task {
            do {
                let schedule = try await service.getSchedulesBetweenStations(fromStation: fromStation, toStation: toStation)
                completion?(.success(schedule))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func stationSchedule(forStation: String, completion: ((Result<StationScheduleResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = StationScheduleService(client: client)

        Task {
            do {
                let stationSchedule = try await service.getStationSchedule(forStation: forStation)
                completion?(.success(stationSchedule))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func threadStations(forUID: String, completion: ((Result<ThreadResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = ThreadStationsService(client: client)

        Task {
            do {
                let threadStations = try await service.getThreadStations(forUID: forUID)
                completion?(.success(threadStations))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func nearestStations(latitude: Double, longitude: Double, distance: Int, completion: ((Result<NearestStationsResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = NearestStationsService(client: client)

        Task {
            do {
                let nearestStations = try await service.getNearestStations(lat: latitude, lng: longitude, distance: distance)
                completion?(.success(nearestStations))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func nearestSettlements(latitude: Double, longitude: Double, distance: Int, completion: ((Result<NearestSettlementResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = NearestSettlementService(client: client)

        Task {
            do {
                let nearestSettlements = try await service.getNearestSettlement(lat: latitude, lng: longitude, distance: distance)
                completion?(.success(nearestSettlements))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func carrier(forCode: String, completion: ((Result<CarrierResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CarrierService(client: client)

        Task {
            do {
                let carrier = try await service.getCarrier(code: forCode)
                completion?(.success(carrier))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func stationsList(completion: ((Result<StationsListResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = StationsListService(client: client)

        Task {
            do {
                let stations = try await service.getStations()
                completion?(.success(stations))
            } catch {
                completion?(.failure(error))
            }
        }
    }

    func copyright(completion: ((Result<CopyrightResponse, Error>) -> Void)? = nil) throws {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CopyrightService(client: client)

        Task {
            do {
                let copyright = try await service.getCopyright()
                completion?(.success(copyright))
            } catch {
                completion?(.failure(error))
            }
        }
    }
}
