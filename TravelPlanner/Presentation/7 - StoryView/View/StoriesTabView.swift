//
//  StoriesTabView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 11.12.2024.
//

import SwiftUI

struct StoriesTabView: View {
    // MARK: - Constants

    @Binding var stories: [Story]

    // MARK: - Public Properties

    @Binding var currentStoryIndex: Int

    var body: some View {
        TabView(selection: $currentStoryIndex) {
            ForEach($stories) { $story in
                StoryView(story: story)
                    .onTapGesture {
                        didTapStory(story: &story)
                    }
                    .tag(stories.firstIndex(of: story) ?? -1)
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    // MARK: - Public Methods

    func didTapStory(story: inout Story) {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
        story.isViewed = true
    }
}
