//
//  ThreadViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 13.11.2024.
//

import SwiftUI
import OpenAPIURLSession

final class SegmentsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var navigationTitle: String = ""
    @Published var isLoading: Bool = false
    @Published var isEmptyListPlaceholderHidden: Bool = true
    @Published var segmentsParams = SegmentsParams()
    public var segments: [Segment] {
        DispatchQueue.main.async {
            if self.isLoading {
                self.isEmptyListPlaceholderHidden = true
            } else {
                self.isEmptyListPlaceholderHidden = !self.allSegments.isEmpty
            }
        }
        return allSegments
    }

    // MARK: - Private Properties

    private var fromStation: StationData?
    private var toStation: StationData?
    private var allSegments: [Segment] = []
    private var isoDateFormatter = ISO8601DateFormatter()

    // MARK: - Initializers

    init() {
        isoDateFormatter.formatOptions = [
            .withFullDate,
            .withFullTime,
            .withDashSeparatorInDate
        ]
    }

    // MARK: - Public Methods

    public func setup(fromStation: StationData, toStation: StationData) {
        self.fromStation = fromStation
        self.toStation = toStation

        navigationTitle = "\(fromStation.stationTitle) → \(toStation.stationTitle)"
        Task {
            try await fetchSegments()
        }
    }

    // MARK: - Private Methods

    private func fetchSegments() async throws {
        guard let fromStation = fromStation?.station?.id, let toStation = toStation?.station?.id else { return }
        await MainActor.run {
            isLoading = true
        }
        var internalAllSegments: [Segment] = []
        let segments = try await schedulesBetweenStations(fromStation: fromStation, toStation: toStation, date: Date(), transfers: true)
        guard let segments = segments.segments else {
            await MainActor.run {
                isLoading = false
            }
            return
        }
        for segment in segments {
            guard let departureDate = isoDateFormatter.date(from: segment.departure ?? ""), let arrivalDate = isoDateFormatter.date(from: segment.arrival ?? "") else { continue }
            let hasTransfers = segment.has_transfers ?? false
            var transferSettlements: [String] = []
            segment.transfers?.forEach { transfer in
                if let popularTitle = transfer.popular_title {
                    transferSettlements.append(popularTitle)
                }
            }
            var carrierId: Int?
            segment.details?.forEach { detail in
                if let thread = detail.value1?.thread, let carrierCode = thread.carrier?.code {
                    carrierId = carrierCode
                }
            }
            if let carrierId = carrierId {
                do {
                    let carrierData = try await carrier(forCode: String(carrierId))
                    let carrier = Carrier(
                        id: carrierId,
                        title: carrierData.carrier?.title ?? "",
                        logo: URL(string: carrierData.carrier?.logo ?? ""),
                        email: carrierData.carrier?.email,
                        phone: carrierData.carrier?.phone
                    )
                    internalAllSegments.append(
                        Segment(
                            departureDate: departureDate,
                            arrivalDate: arrivalDate,
                            hasTransfers: hasTransfers,
                            transferTitle: transferSettlements.joined(separator: ", "),
                            carrier: carrier
                        )
                    )
                } catch {
                    print(error)
                }
            }
        }
        await MainActor.run { [internalAllSegments] in
            allSegments = internalAllSegments
            isLoading = false
        }
    }

    private func carrier(forCode: String) async throws -> CarrierResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CarrierService(client: client)
        return try await service.getCarrier(code: forCode)
    }

    private func schedulesBetweenStations(fromStation: String, toStation: String, date: Date, transfers: Bool) async throws -> SchedulesBetweenStationsResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = SchedulesBetweenStationService(client: client)
        return try await service.getSchedulesBetweenStations(fromStation: fromStation, toStation: toStation, date: date, transfers: transfers)
    }
}
