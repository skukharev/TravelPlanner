//
//  StoriesView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 10.12.2024.
//

import SwiftUI

struct StoriesView: View {
    // MARK: - Types

    private enum Constants {
        static let closeButtonTopPadding: CGFloat = 57
        static let closeButtonTrailingPadding: CGFloat = 12
        static let progressBarPadding = EdgeInsets(top: 28, leading: 12, bottom: 12, trailing: 12)
    }

    // MARK: - Property Wrappers

    @Binding var stories: [Story]
    @Environment(\.presentationMode)
    var presentationMode
    @Binding var currentStoryIndex: Int
    @Binding var isDetailedStoryViewPresented: Bool
    @State private var currentProgress: CGFloat = 0
    @State private var oldStoryIndex: Int = 0

    // MARK: - Public Properties

    var body: some View {
        GeometryReader { geo in
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
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width == 0 && value.translation.height == 0 {
                            if value.location.x > geo.size.width / 2 {
                                moveToNextStory()
                            } else {
                                moveToPreviousStory()
                            }
                        } else {
                            if value.translation.width > 20 {
                                moveToPreviousStory()
                            } else if value.translation.width < -20 {
                                moveToNextStory()
                            } else if value.translation.height > 20 {
                                dismissView()
                            }
                        }
                    }
            )
            .onAppear {
                currentProgress = timerConfiguration.progress(for: currentStoryIndex)
                oldStoryIndex = currentStoryIndex
            }
        }
    }

    // MARK: - Private Properties

    private var timerConfiguration: TimerConfiguration { .init(storiesCount: stories.count) }

    // MARK: - Private Methods

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }

    private func moveToNextStory() {
        currentStoryIndex = min(currentStoryIndex + 1, stories.count - 1)
    }

    private func moveToPreviousStory() {
        currentStoryIndex = max(0, currentStoryIndex - 1)
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
        if newProgress >= 1.0 {
            isDetailedStoryViewPresented = false
        }
        let index = timerConfiguration.index(for: newProgress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}

struct StoriesPreview: View {
    @State var stories = StoryFactory().stories
    @State var currentStoryIndex: Int = 1
    @State var isDetailedStoryViewPresented: Bool = true
    @StateObject private var appSettings = AppSettings()

    var body: some View {
        StoriesView(
            stories: $stories,
            currentStoryIndex: $currentStoryIndex,
            isDetailedStoryViewPresented: $isDetailedStoryViewPresented
        )
        .environmentObject(appSettings)
    }
}

#Preview {
    StoriesPreview()
}
