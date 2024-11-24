//
//  DaysFormatter.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 19.11.2024.
//

import Foundation

final class HoursFormatter {
    // MARK: - Constants

    static let shared = HoursFormatter()

    // MARK: - Private Properties

    let formatter: DateComponentsFormatter

    // MARK: - Initializers

    init(formatter: DateComponentsFormatter) {
        self.formatter = formatter
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour]
    }

    convenience init() {
        self.init(formatter: DateComponentsFormatter())
    }

    // MARK: - Public Methods

    func hoursToStringWithSuffix(_ value: Int) -> String {
        guard let result = formatter.string(from: Double(value) * 60 * 60) else { return "" }
        return result
    }
}
