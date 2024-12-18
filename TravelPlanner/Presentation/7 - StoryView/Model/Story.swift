//
//  StoriesModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import UIKit

struct Story: Identifiable, Hashable, Sendable {
    let id: UUID
    let previewImage: UIImage
    let image: UIImage
    let title: String
    let description: String
    var isViewed = false
}
