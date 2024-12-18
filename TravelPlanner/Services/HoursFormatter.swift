//
//  DaysFormatter.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 19.11.2024.
//

import Foundation

struct HoursFormatter: Sendable {
    // MARK: - Constants

    static let shared = HoursFormatter(formatter: DateComponentsFormatter())

    // MARK: - Private Properties

    let formatter: DateComponentsFormatter

    // MARK: - Initializers

    init(formatter: DateComponentsFormatter) {
        self.formatter = formatter
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour]
    }

    // MARK: - Public Methods

    func hoursToStringWithSuffix(_ value: Int) -> String {
        guard let result = formatter.string(from: Double(value) * 60 * 60) else { return "" }
        return result
    }
}
