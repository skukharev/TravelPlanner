//
//  StoryView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.12.2024.
//

import SwiftUI

struct StoryView: View {
    // MARK: - Types

    private enum Constants {
        static let imageCornerRadius: CGFloat = 40
        static let backgroundColor = Color.black
        static let storyTitleFont = GlobalConstants.ypBold34
        static let storyDescriptionFont = GlobalConstants.ypRegular20
        static let textElementsVerticalSpacing: CGFloat = 16
        static let textElementsColor: Color = .white
        static let textElementsPadding = EdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16)
        static let textElementsStartingScaleValue: CGFloat = 1.5
        static let animationDuration: TimeInterval = 0.3
    }

    // MARK: - Property Wrappers

    @StateObject private var viewModel = StoryViewModel()
    @EnvironmentObject private var appSettings: AppSettings
    @Binding var story: Story

    // MARK: - Public Properties

    var body: some View {
        Constants.backgroundColor
            .ignoresSafeArea()
            .overlay {
                ZStack {
                    Image(uiImage: story.image)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: Constants.imageCornerRadius))
                    VStack {
                        Spacer()
                        VStack(alignment: .leading, spacing: Constants.textElementsVerticalSpacing) {
                            Text(story.title)
                                .font(Constants.storyTitleFont)
                                .foregroundColor(Constants.textElementsColor)
                                .scaleEffect(viewModel.viewInFinalState ? 1 : Constants.textElementsStartingScaleValue)
                                .animation(.easeInOut(duration: Constants.animationDuration), value: viewModel.viewInFinalState)
                            Text(story.description)
                                .font(Constants.storyDescriptionFont)
                                .lineLimit(3)
                                .foregroundColor(Constants.textElementsColor)
                                .scaleEffect(viewModel.viewInFinalState ? 1 : Constants.textElementsStartingScaleValue)
                                .animation(.easeInOut(duration: Constants.animationDuration), value: viewModel.viewInFinalState)
                        }
                        .padding(Constants.textElementsPadding)
                    }
                }
            }
            .task {
                viewModel.onAppearView(story: &story, appSettings: appSettings)
            }
            .onDisappear {
                viewModel.onDisappearView()
            }
    }
}

struct StoryPreview: View {
    @State private var story = StoryFactory().stories[0]

    var body: some View {
        StoryView(story: $story)
    }
}

#Preview {
    StoryPreview()
}
