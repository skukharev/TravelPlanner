//
//  StoryViewStatus.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 13.12.2024.
//

import Foundation

struct StoryViewStatus: Codable, Sendable {
    let id: UUID
    var isViewed: Bool
}
