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
    // swiftlint:disable:next function_body_length
    init() {
        let story1 = Story(
            id: UUID.init(uuidString: "669e5afe-bd6c-4a74-98a3-31ed512efe84") ?? UUID(),
            previewImage: Asset.Images.Stories.story1Preview.image,
            image: Asset.Images.Stories.story1Detail1.image,
            title: Array(repeating: "Text1", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story2 = Story(
            id: UUID.init(uuidString: "69a8e0d8-e7a2-473f-9365-eb4a998eeb08") ?? UUID(),
            previewImage: Asset.Images.Stories.story2Preview.image,
            image: Asset.Images.Stories.story2Detail1.image,
            title: Array(repeating: "Text2", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story3 = Story(
            id: UUID.init(uuidString: "de108595-fe41-4e4a-88d5-f452cf34eda5") ?? UUID(),
            previewImage: Asset.Images.Stories.story3Preview.image,
            image: Asset.Images.Stories.story3Detail1.image,
            title: Array(repeating: "Text3", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story4 = Story(
            id: UUID.init(uuidString: "fbbec7e4-6a6a-4b50-8fd5-b0b5e75c1f16") ?? UUID(),
            previewImage: Asset.Images.Stories.story4Preview.image,
            image: Asset.Images.Stories.story4Detail1.image,
            title: Array(repeating: "Text4", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story5 = Story(
            id: UUID.init(uuidString: "820a14dc-555e-460f-a76a-44a0087e0e33") ?? UUID(),
            previewImage: Asset.Images.Stories.story5Preview.image,
            image: Asset.Images.Stories.story5Detail1.image,
            title: Array(repeating: "Text5", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story6 = Story(
            id: UUID.init(uuidString: "7d342a24-e8a8-4891-893a-784ec13f31c7") ?? UUID(),
            previewImage: Asset.Images.Stories.story6Preview.image,
            image: Asset.Images.Stories.story6Detail1.image,
            title: Array(repeating: "Text6", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story7 = Story(
            id: UUID.init(uuidString: "44e288c2-218a-4bf9-9d78-3d93c7f72875") ?? UUID(),
            previewImage: Asset.Images.Stories.story7Preview.image,
            image: Asset.Images.Stories.story7Detail1.image,
            title: Array(repeating: "Text7", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story8 = Story(
            id: UUID.init(uuidString: "bb6713b5-3ec6-4ee7-9fe1-b2faef434386") ?? UUID(),
            previewImage: Asset.Images.Stories.story8Preview.image,
            image: Asset.Images.Stories.story8Detail1.image,
            title: Array(repeating: "Text8", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )
        let story9 = Story(
            id: UUID.init(uuidString: "44ddb3a6-a11c-46a9-b5ca-7b19ce000263") ?? UUID(),
            previewImage: Asset.Images.Stories.story9Preview.image,
            image: Asset.Images.Stories.story9Detail1.image,
            title: Array(repeating: "Text9", count: 9).joined(separator: " "),
            description: Array(repeating: "Text", count: 20).joined(separator: " ")
        )

        self.stories = [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
