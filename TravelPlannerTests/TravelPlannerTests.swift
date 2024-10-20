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
    func testSchedulesBetweenStations() async throws {
        let expectation = expectation(description: "testSchedulesBetweenStations")
        do {
            let result = try await travelPlanner.schedulesBetweenStations(fromStation: "c146", toStation: "c213")
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/schedule/
    func testStationSchedule() async throws {
        let expectation = expectation(description: "testStationSchedule")
        do {
            let result = try await travelPlanner.stationSchedule(forStation: "s9613830")
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/thread/
    func testThreadStations() async throws {
        let expectation = expectation(description: "testThreadStations")
        do {
            let result = try await travelPlanner.threadStations(forUID: "6296x6294x6292x6291_0_9613602_g24_4")
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/nearest_stations/
    func testNearestStations() async throws {
        let expectation = expectation(description: "testNearestStations")
        do {
            let result = try await travelPlanner.nearestStations(latitude: 45.035470, longitude: 38.975313, distance: 50)
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/nearest_settlement/
    func testNearestSettlements() async throws {
        let expectation = expectation(description: "testNearestSettlements")
        do {
            let result = try await travelPlanner.nearestSettlements(latitude: 59.864177, longitude: 30.319163, distance: 50)
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/carrier/
    func testCarrier() async throws {
        let expectation = expectation(description: "testCarrier")
        do {
            let result = try await travelPlanner.carrier(forCode: "1369")
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/stations_list/
    func testStationsList() async throws {
        let expectation = expectation(description: "testStations")
        do {
            let result = try await travelPlanner.stationsList()
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }

    /// Проверяет работоспособность ручки https://api.rasp.yandex.net/v3.0/copyright/
    func testCopyright() async throws {
        let expectation = expectation(description: "testCopyright")
        do {
            let result = try await travelPlanner.copyright()
            XCTAssertNotNil(result)
            expectation.fulfill()
        } catch {
            XCTFail(error.localizedDescription)
        }
        await fulfillment(of: [expectation], timeout: 10)
    }
}
