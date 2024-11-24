//
//  Station.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 08.11.2024.
//

import UIKit

struct StationData: Identifiable, Hashable {
    // MARK: - Constants

    let id = UUID()
    let stationType: StationType

    // MARK: - Public Properties

    var city: City?
    var station: Station?
    var stationTitle: String {
        guard
            let city = city,
            let station = station
        else {
            return stationType.prompt
        }
        return city.name + " (" + station.name + ")"
    }
    var isEmpty: Bool {
        return (city != nil && station != nil) ? false : true
    }

    // MARK: - Initializers

    init(stationType: StationType) {
        self.stationType = stationType
    }

    init(stationType: StationType, city: City, station: Station) {
        self.stationType = stationType
        self.city = city
        self.station = station
    }
}
