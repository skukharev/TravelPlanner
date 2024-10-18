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
        /// (1) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/search/
        do {
            try schedulesBetweenStations()
        } catch {
            print(error)
        }
        /// (2) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/schedule/
        do {
            try stationSchedule()
        } catch {
            print(error)
        }
        /// (3) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/thread/
        do {
            try threadStations()
        } catch {
            print(error)
        }
        /// (4) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/nearest_stations/
        do {
            try nearestStations()
        } catch {
            print(error)
        }
        /// (5) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/nearest_settlement/
        do {
            try nearestSettlements()
        } catch {
            print(error)
        }
        /// (6) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/carrier/
        do {
            try carrier()
        } catch {
            print(error)
        }
        /// (7) Проверка работоспособности ручки https://yandex.ru/dev/rasp/doc/ru/reference/stations_list
        do {
            try stationsList()
        } catch {
            print(error)
        }
        /// (8) Проверка работоспособности ручки https://api.rasp.yandex.net/v3.0/copyright/
        try? copyright()
    }

    func schedulesBetweenStations() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = SchedulesBetweenStationService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getSchedulesBetweenStations(fromStation: "c146", toStation: "c213")
                switch result {
                case .success:
                    print("(1) ============ https://api.rasp.yandex.net/v3.0/search/ - OK ==============")
                case .failure(let error):
                    print("(1) ============ https://api.rasp.yandex.net/v3.0/search/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(1) ============ https://api.rasp.yandex.net/v3.0/search/ - Error ==============")
                print(error)
            }
        }
    }

    func stationSchedule() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = StationScheduleService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getStationSchedule(forStation: "s9600213")
                switch result {
                case .success:
                    print("(2) ============ https://api.rasp.yandex.net/v3.0/schedule/ - OK ==============")
                case .failure(let error):
                    print("(2) ============ https://api.rasp.yandex.net/v3.0/schedule/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(2) ============ https://api.rasp.yandex.net/v3.0/schedule/ - Error ==============")
                print(error)
            }
        }
    }

    func threadStations() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = ThreadStationsService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getThreadStations(forUID: "6296x6294x6292x6291_0_9613602_g24_4")
                switch result {
                case .success:
                    print("(3) ============ https://api.rasp.yandex.net/v3.0/thread/ - OK ==============")
                case .failure(let error):
                    print("(3) ============ https://api.rasp.yandex.net/v3.0/thread/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(3) ============ https://api.rasp.yandex.net/v3.0/thread/ - Error ==============")
            }
        }
    }

    func nearestStations() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = NearestStationsService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                _ = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 50)
                print("(4) ============ https://api.rasp.yandex.net/v3.0/nearest_stations/ - OK ==============")
            } catch {
                print("(4) ============ https://api.rasp.yandex.net/v3.0/nearest_stations/ - Error ==============")
                print(error)
            }
        }
    }

    func nearestSettlements() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = NearestSettlementService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163, distance: 50)
                switch result {
                case .success:
                    print("(5) ============ https://api.rasp.yandex.net/v3.0/nearest_stations/ - OK ==============")
                case .failure(let error):
                    print("(5) ============ https://api.rasp.yandex.net/v3.0/nearest_stations/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(5) ============ https://api.rasp.yandex.net/v3.0/nearest_stations/ - Error ==============")
                print(error)
            }
        }
    }

    func carrier() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = CarrierService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getCarrier(code: "1369")
                switch result {
                case .success:
                    print("(6) ============ https://api.rasp.yandex.net/v3.0/carrier/ - OK ==============")
                case .failure(let error):
                    print("(6) ============ https://api.rasp.yandex.net/v3.0/carrier/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(6) ============ https://api.rasp.yandex.net/v3.0/carrier/ - Error ==============")
                print(error)
            }
        }
    }

    func stationsList() throws {
        let transport = URLSessionTransport()
        transport.configuration.session.configuration.timeoutIntervalForRequest = 1800
        let client = Client(serverURL: try Servers.server1(), transport: transport)

        let service = StationsListService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                let result = try await service.getStations()
                switch result {
                case .success:
                    print("(7) ============ https://api.rasp.yandex.net/v3.0/stations_list/ - OK ==============")
                case .failure(let error):
                    print("(7) ============ https://api.rasp.yandex.net/v3.0/stations_list/ - Error ==============")
                    print(error)
                }
            } catch {
                print("(7) ============ https://api.rasp.yandex.net/v3.0/stations_list/ - Error ==============")
                print(error)
            }
        }
    }

    func copyright() throws {
        let client = Client(serverURL: try Servers.server1(), transport: URLSessionTransport())

        let service = CopyrightService(
            client: client,
            apikey: GlobalConstants.yandexSchedulesApi
        )

        Task {
            do {
                _ = try await service.getCopyright()
                print("(8) ============ https://api.rasp.yandex.net/v3.0/copyright/ - OK ==============")
            } catch {
                print("(8) ============ https://api.rasp.yandex.net/v3.0/copyright/ - Error ==============")
                print(error)
            }
        }
    }
}
