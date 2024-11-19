//
//  Thread.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.11.2024.
//

import Foundation

struct Segment: Identifiable, Hashable {
    // MARK: - Constants

    let id = UUID()
    let departureDate: Date
    let arrivalDate: Date
    let hasTransfers: Bool
    let transferTitle: String?
    let carrier: Carrier

    // MARK: - Private Properties

    private var dateFormatter = DateFormatter()

    // MARK: - Initializers

    init(departureDate: Date, arrivalDate: Date, hasTransfers: Bool, transferTitle: String? = nil, carrier: Carrier) {
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
        self.hasTransfers = hasTransfers
        self.transferTitle = transferTitle
        self.carrier = carrier
    }

    // MARK: - Public Methods

    public func getTransferTitle() -> String? {
        if hasTransfers, let transferTitle = transferTitle {
            return L10n.transferPrefixText + " " + transferTitle
        } else {
            return nil
        }
    }

    public func getDepartureDay() -> String {
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: departureDate)
    }

    public func getDepartureTime() -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: departureDate)
    }

    public func getArrivalTime() -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: arrivalDate)
    }

    public func getSegmentDurationHours() -> String {
        let diffComponents = Calendar.current.dateComponents([.hour], from: departureDate, to: arrivalDate)
        guard let hours = diffComponents.hour else { return "" }
        return HoursFormatter.shared.hoursToStringWithSuffix(hours)
    }
}
