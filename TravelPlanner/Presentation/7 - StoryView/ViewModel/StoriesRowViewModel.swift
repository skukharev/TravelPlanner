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

    func detailedStoryViewPresentation(stories: [Story], story: Story) {
        let params: AnalyticsEventParam = ["screen": "Main", "item": "showStory", "itemId": story.id.uuidString]
        AnalyticsService.report(event: "click", params: params)
        print("Зарегистрировано событие аналитики 'click' с параметрами \(params)")
        guard let storyIndex = storyIndex(for: story, inThe: stories) else { return }
        self.storyIndex = storyIndex
        isDetailedStoryViewPresented = true
    }

    // MARK: - Private Methods

    private func storyIndex(for story: Story, inThe stories: [Story]) -> Int? {
        return stories.firstIndex { $0.id == story.id }
    }
}
