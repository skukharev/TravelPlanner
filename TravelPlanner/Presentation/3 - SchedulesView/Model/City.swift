//
//  City.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.11.2024.
//

struct City: Identifiable, Hashable, Sendable {
    var id: String
    var name: String
    var stations: [Station] = []
}
