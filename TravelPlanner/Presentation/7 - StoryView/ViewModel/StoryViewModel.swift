//
//  StoryViewModel.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 15.12.2024.
//

import Foundation

@MainActor
final class StoryViewModel: ObservableObject {
    // MARK: - Public Properties

    @Published var viewInFinalState = false

    // MARK: - Public Methods

    func onAppearView(story: inout Story, appSettings: AppSettings) {
        viewInFinalState = true
        story.isViewed = true
        appSettings.saveStoryIsViewedStatus(
            storyId: story.id,
            isViewed: story.isViewed
        )
    }

    func onDisappearView() {
        viewInFinalState = false
    }
}
