//
//  StoryFactory.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.12.2024.
//

import Foundation

final class StoryFactory: ObservableObject {
    // MARK: - Public Properties

    @Published var stories: [Story] = []

    // MARK: - Initializers
    init() {
        let story1 = Story(
            previewImage: Asset.Images.Stories.story1Preview.image,
            image: Asset.Images.Stories.story1Detail1.image,
            title: Array(repeating: "Text1", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story2 = Story(
            previewImage: Asset.Images.Stories.story2Preview.image,
            image: Asset.Images.Stories.story2Detail1.image,
            title: Array(repeating: "Text2", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story3 = Story(
            previewImage: Asset.Images.Stories.story3Preview.image,
            image: Asset.Images.Stories.story3Detail1.image,
            title: Array(repeating: "Text3", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story4 = Story(
            previewImage: Asset.Images.Stories.story4Preview.image,
            image: Asset.Images.Stories.story4Detail1.image,
            title: Array(repeating: "Text4", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story5 = Story(
            previewImage: Asset.Images.Stories.story5Preview.image,
            image: Asset.Images.Stories.story5Detail1.image,
            title: Array(repeating: "Text5", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story6 = Story(
            previewImage: Asset.Images.Stories.story6Preview.image,
            image: Asset.Images.Stories.story6Detail1.image,
            title: Array(repeating: "Text6", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story7 = Story(
            previewImage: Asset.Images.Stories.story7Preview.image,
            image: Asset.Images.Stories.story7Detail1.image,
            title: Array(repeating: "Text7", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story8 = Story(
            previewImage: Asset.Images.Stories.story8Preview.image,
            image: Asset.Images.Stories.story8Detail1.image,
            title: Array(repeating: "Text8", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story9 = Story(
            previewImage: Asset.Images.Stories.story9Preview.image,
            image: Asset.Images.Stories.story9Detail1.image,
            title: Array(repeating: "Text9", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )

        self.stories = [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
