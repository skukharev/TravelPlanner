//
//  Carrier.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 16.11.2024.
//

import Foundation

struct Carrier: Identifiable, Hashable {
    let id: Int
    let title: String
    let logo: URL?
    let email: String?
    let phone: String?
}
