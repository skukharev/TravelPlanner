//
//  Station.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 08.11.2024.
//

import UIKit

enum StationType: String {
    case fromStation
    case toStation

    var prompt: String {
        switch self {
        case .fromStation: return L10n.fromStationPrompt
        case .toStation: return L10n.toStationPrompt
        }
    }
}

struct Station: Identifiable, Hashable {
    var id = UUID()
    let stationType: StationType
    var city: String?
    var station: String?
    var stationTitle: String {
        guard
            let city = city,
            let station = station
        else {
            return stationType.prompt
        }
        return city + " ( " + station + " )"
    }

    init(stationType: StationType) {
        self.stationType = stationType
    }
}
