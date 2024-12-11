//
//  StoriesRowViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.12.2024.
//

import Foundation

final class StoriesRowViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var isDetailedStoryViewPresented: Bool = false
    @Published var storyIndex: Int = 0

    // MARK: - Public Methods

    func detailedStoryViewPresentation(story: Story) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "showStory", "itemId": story.id.uuidString]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        guard let storyIndex = StoryFactory.shared.storyIndex(for: story) else { return }
        self.storyIndex = storyIndex
        isDetailedStoryViewPresented = true
    }
}
