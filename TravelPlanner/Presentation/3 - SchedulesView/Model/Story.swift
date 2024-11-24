//
//  StoriesModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import UIKit

struct Story: Identifiable, Hashable {
    var id = UUID()
    var previewImage: UIImage
    var images: [UIImage]
    var title: String
    var description: String
    var isViewed: Bool = false
}
