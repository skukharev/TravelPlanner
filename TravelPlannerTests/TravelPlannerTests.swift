//
//  TravelPlannerTests.swift
//  TravelPlannerTests
//
//  Created by Сергей Кухарев on 19.10.2024.
//

import XCTest
import OpenAPIURLSession
@testable import TravelPlanner

final class TravelPlannerTests: XCTestCase {
    let travelPlanner = TravelPlannerApp()

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/search/
    func testSchedulesBetweenStations() throws {
        let expectation = expectation(description: "testSchedulesBetweenStations")
        try travelPlanner.schedulesBetweenStations(fromStation: "c146", toStation: "c213") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/schedule/
    func testStationSchedule() throws {
        let expectation = expectation(description: "testStationSchedule")
        try travelPlanner.stationSchedule(forStation: "s9613830") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/thread/
    func testThreadStations() throws {
        let expectation = expectation(description: "testThreadStations")
        try travelPlanner.threadStations(forUID: "6296x6294x6292x6291_0_9613602_g24_4") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/nearest_stations/
    func testNearestStations() throws {
        let expectation = expectation(description: "testNearestStations")
        try travelPlanner.nearestStations(latitude: 45.035470, longitude: 38.975313, distance: 50) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/nearest_settlement/
    func testNearestSettlements() throws {
        let expectation = expectation(description: "testNearestSettlements")
        try travelPlanner.nearestSettlements(latitude: 59.864177, longitude: 30.319163, distance: 50) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/carrier/
    func testCarrier() throws {
        let expectation = expectation(description: "testCarrier")
        try travelPlanner.carrier(forCode: "1369") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/stations_list/
    func testStationsList() throws {
        let expectation = expectation(description: "testStations")
        try travelPlanner.stationsList { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/copyright/
    func testCopyright() throws {
        let expectation = expectation(description: "testCopyright")
        try travelPlanner.copyright { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
