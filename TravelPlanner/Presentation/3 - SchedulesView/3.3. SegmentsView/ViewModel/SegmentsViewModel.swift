//
//  ThreadViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 13.11.2024.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

@MainActor
final class SegmentsViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var navigationTitle: String = ""
    @Published var isLoading: Bool = false
    @Published var loadingError: ErrorViewType?
    @Published var isEmptyListPlaceholderHidden: Bool = true
    @Published var isSegmentParamsPresented: Bool = false
    @Published var segmentsParams = SegmentsParams()
    var segments: [Segment] {
        if segmentsParams.isEmpty {
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !self.allSegments.isEmpty
                }
            }
            return allSegments
        } else {
            let filteredSegments = allSegments.filter { segment in
                if segment.hasTransfers && !(segmentsParams.isShowTransfers ?? true) {
                    return false
                }
                let hour = segment.getDepartureHour()
                if hour >= 6 && hour <= 11 && segmentsParams.departureTimes.first(where: { $0.type == .morning })?.value ?? false {
                    return true
                }
                if hour >= 12 && hour <= 17 && segmentsParams.departureTimes.first(where: { $0.type == .afternoon })?.value ?? false {
                    return true
                }
                if hour >= 18 && segmentsParams.departureTimes.first(where: { $0.type == .evening })?.value ?? false {
                    return true
                }
                if hour <= 5 && segmentsParams.departureTimes.first(where: { $0.type == .night })?.value ?? false {
                    return true
                }
                return false
            }
            DispatchQueue.main.async {
                if self.isLoading {
                    self.isEmptyListPlaceholderHidden = true
                } else {
                    self.isEmptyListPlaceholderHidden = !filteredSegments.isEmpty
                }
            }
            return filteredSegments
        }
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

    func setup(fromStation: StationData, toStation: StationData) async {
        self.fromStation = fromStation
        self.toStation = toStation
        loadingError = nil

        navigationTitle = "\(fromStation.stationTitle) → \(toStation.stationTitle)"
        do {
            try await fetchSegments()
        } catch ErrorViewType.serverError {
            loadingError = ErrorViewType.serverError
        } catch {
            loadingError = ErrorViewType.noInternetError
        }
    }

    func showSegmentParams() {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "segmentParamsButton"]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        isSegmentParamsPresented = true
    }

    // MARK: - Private Methods

    private func carrier(forCode: String) async throws -> CarrierResponse {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: GlobalConstants.yandexSchedulesApi)]
        )

        let service = CarrierService(client: client)
        return try await service.getCarrier(code: forCode)
    }

    private func fillRawSegmentsData() async throws -> [Components.Schemas.Segment] {
        var result: [Components.Schemas.Segment] = []
        guard let fromStation = fromStation?.station?.id, let toStation = toStation?.station?.id else { return result }
        let currentDate = Date()
        let dates: [Date] = [
            currentDate,
            Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate,
            Calendar.current.date(byAdding: .day, value: 2, to: currentDate) ?? currentDate
        ]
        for date in dates {
            let segments = try await schedulesBetweenStations(
                fromStation: fromStation,
                toStation: toStation,
                date: date,
                transfers: true
            )
            if let segments = segments.segments {
                result.append(contentsOf: segments)
            }
        }
        return result
    }

    private func fetchSegments() async throws {
        await setupIsLoading(true)
        var internalAllSegments: [Segment] = []
        let dateSegments = try await fillRawSegmentsData()
        if dateSegments.isEmpty {
            await setupIsLoading(false)
            return
        }
        for segment in dateSegments {
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
            }
        }
        await MainActor.run { [internalAllSegments] in
            allSegments = internalAllSegments
            isLoading = false
        }
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

    private func setupIsLoading(_ value: Bool) async {
        await MainActor.run {
            isLoading = value
        }
    }
}
