//
//  SchedulesViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import Foundation

final class SchedulesViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var stories: [Story]

    // MARK: - Initializers

    init() {
        let story1 = Story(
            previewImage: Asset.Images.Stories.story1Preview.image,
            images: [Asset.Images.Stories.story1Detail1.image, Asset.Images.Stories.story1Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story2 = Story(
            previewImage: Asset.Images.Stories.story2Preview.image,
            images: [Asset.Images.Stories.story2Detail1.image, Asset.Images.Stories.story2Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story3 = Story(
            previewImage: Asset.Images.Stories.story3Preview.image,
            images: [Asset.Images.Stories.story3Detail1.image, Asset.Images.Stories.story3Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story4 = Story(
            previewImage: Asset.Images.Stories.story4Preview.image,
            images: [Asset.Images.Stories.story4Detail1.image, Asset.Images.Stories.story4Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story5 = Story(
            previewImage: Asset.Images.Stories.story5Preview.image,
            images: [Asset.Images.Stories.story5Detail1.image, Asset.Images.Stories.story5Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story6 = Story(
            previewImage: Asset.Images.Stories.story6Preview.image,
            images: [Asset.Images.Stories.story6Detail1.image, Asset.Images.Stories.story6Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story7 = Story(
            previewImage: Asset.Images.Stories.story7Preview.image,
            images: [Asset.Images.Stories.story7Detail1.image, Asset.Images.Stories.story7Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story8 = Story(
            previewImage: Asset.Images.Stories.story8Preview.image,
            images: [Asset.Images.Stories.story8Detail1.image, Asset.Images.Stories.story8Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story9 = Story(
            previewImage: Asset.Images.Stories.story9Preview.image,
            images: [Asset.Images.Stories.story9Detail1.image, Asset.Images.Stories.story9Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )

        self.stories = [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
