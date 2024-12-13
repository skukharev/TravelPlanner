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
            title: "Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1 Text1",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story2 = Story(
            previewImage: Asset.Images.Stories.story2Preview.image,
            image: Asset.Images.Stories.story2Detail1.image,
            title: "Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2 Text2",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story3 = Story(
            previewImage: Asset.Images.Stories.story3Preview.image,
            image: Asset.Images.Stories.story3Detail1.image,
            title: "Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3 Text3",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story4 = Story(
            previewImage: Asset.Images.Stories.story4Preview.image,
            image: Asset.Images.Stories.story4Detail1.image,
            title: "Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4 Text4",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story5 = Story(
            previewImage: Asset.Images.Stories.story5Preview.image,
            image: Asset.Images.Stories.story5Detail1.image,
            title: "Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5 Text5",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story6 = Story(
            previewImage: Asset.Images.Stories.story6Preview.image,
            image: Asset.Images.Stories.story6Detail1.image,
            title: "Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6 Text6",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story7 = Story(
            previewImage: Asset.Images.Stories.story7Preview.image,
            image: Asset.Images.Stories.story7Detail1.image,
            title: "Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7 Text7",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story8 = Story(
            previewImage: Asset.Images.Stories.story8Preview.image,
            image: Asset.Images.Stories.story8Detail1.image,
            title: "Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8 Text8",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )
        let story9 = Story(
            previewImage: Asset.Images.Stories.story9Preview.image,
            image: Asset.Images.Stories.story9Detail1.image,
            title: "Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9 Text9",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        )

        self.stories = [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
