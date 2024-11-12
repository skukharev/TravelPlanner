//
//  StationType.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 11.11.2024.
//

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
