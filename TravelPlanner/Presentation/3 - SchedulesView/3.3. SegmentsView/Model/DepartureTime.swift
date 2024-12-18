//
//  DepartureTime.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.11.2024.
//

import Foundation

enum DepartureTimeType {
    case morning
    case afternoon
    case evening
    case night
}

struct DepartureTime: Hashable, Identifiable, Sendable {
    let id = UUID()
    let type: DepartureTimeType
    var name: String {
        switch type {
        case .morning: return L10n.departureTimeMorning
        case .afternoon: return L10n.departureTimeAfternoon
        case .evening: return L10n.departureTimeEvening
        case .night: return L10n.departureTimeNight
        }
    }
    var value: Bool
}
