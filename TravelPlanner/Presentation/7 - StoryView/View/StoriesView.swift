//
//  StoriesView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 10.12.2024.
//

import SwiftUI

struct StoriesView: View {
    // MARK: - Constants

    enum Constants {
        static let closeButtonTopPadding: CGFloat = 57
        static let closeButtonTrailingPadding: CGFloat = 12
        static let progressBarPadding = EdgeInsets(top: 28, leading: 12, bottom: 12, trailing: 12)
    }

    @Binding var stories: [Story]

    // MARK: - Public Properties

    @Environment(\.presentationMode)
    var presentationMode
    @Binding var currentStoryIndex: Int
    @State var currentProgress: CGFloat = 0

    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(stories: $stories, currentStoryIndex: $currentStoryIndex)
                .onChange(of: currentStoryIndex) { newValue in
                    didChangeCurrentIndex(oldIndex: oldStoryIndex, newIndex: newValue)
                    oldStoryIndex = newValue
                }
            StoriesProgressBar(
                storiesCount: stories.count,
                timerConfiguration: timerConfiguration,
                currentProgress: $currentProgress
            )
                .padding(Constants.progressBarPadding)
                .onChange(of: currentProgress) { newValue in
                    didChangeCurrentProgress(newProgress: newValue)
                }
            CloseButton {
                dismissView()
            }
            .padding(.top, Constants.closeButtonTopPadding)
            .padding(.trailing, Constants.closeButtonTrailingPadding)
        }
        .gesture(
            DragGesture(minimumDistance: 20, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.height > 0 {
                        dismissView()
                    }
                }
        )
        .onAppear {
            currentProgress = timerConfiguration.progress(for: currentStoryIndex)
            oldStoryIndex = currentStoryIndex
        }
    }

    // MARK: - Private Properties

    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }
    @State private var oldStoryIndex: Int = 0

    // MARK: - Private Methods

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }

    private func didChangeCurrentIndex(oldIndex: Int, newIndex: Int) {
        guard oldIndex != newIndex else { return }
        let progress = timerConfiguration.progress(for: newIndex)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }

    private func didChangeCurrentProgress(newProgress: CGFloat) {
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        DispatchQueue.main.async { [currentStoryIndex] in
            stories[currentStoryIndex].isViewed = true
        }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

struct StoriesPreview: View {
    @State var stories = StoryFactory().stories
    @State var currentStoryIndex: Int = 1

    var body: some View {
        StoriesView(stories: $stories, currentStoryIndex: $currentStoryIndex)
    }
}

#Preview {
    StoriesPreview()
}
