//
//  StoriesRowView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import SwiftUI

struct StoriesRowView: View {
    // MARK: - Types

    private enum Constants {
        static let previewImageSizeWidth: CGFloat = 92
        static let previewImageSizeHeight: CGFloat = 140
        static let previewImageBorderColor: Color = .blueUniversal
        static let previewImageBorderWidth: CGFloat = 4
        static let titleFont = GlobalConstants.ypRegular12
        static let titleColor: Color = .white
        static let titleLinesCount = 3
        static let titleWidth: CGFloat = 76
        static let titleHeight: CGFloat = 45
        static let titleVerticalOffsetRelationToImage: CGFloat = 36
        static let notViewedRowOpacity: CGFloat = 1
        static let viewedRowOpacity: CGFloat = 0.5
    }

    // MARK: - Constants

    let impactMed = UIImpactFeedbackGenerator(style: .medium)

    // MARK: - Property Wrappers

    @Binding var stories: [Story]
    @Binding var story: Story
    @StateObject private var viewModel = StoriesRowViewModel()

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            Image(uiImage: story.previewImage)
                .resizable()
                .scaledToFit()
                .opacity(Double(story.isViewed ? Constants.viewedRowOpacity : Constants.notViewedRowOpacity))
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: GlobalConstants.defaultCornerRadius
                    )
                )
                .overlay(
                    RoundedRectangle(
                        cornerRadius: GlobalConstants.defaultCornerRadius
                    )
                    .stroke(
                        story.isViewed ? Color.clear : Constants.previewImageBorderColor,
                        lineWidth: story.isViewed ? 0 : Constants.previewImageBorderWidth
                    )
                )
            Text(story.title)
                .font(Constants.titleFont)
                .foregroundStyle(Constants.titleColor)
                .frame(
                    width: Constants.titleWidth,
                    height: Constants.titleHeight
                )
                .lineLimit(Constants.titleLinesCount)
                .offset(y: Constants.titleVerticalOffsetRelationToImage)
                .opacity(Double(story.isViewed ? Constants.viewedRowOpacity : Constants.notViewedRowOpacity))
        }
        .frame(
            maxWidth: Constants.previewImageSizeWidth,
            maxHeight: Constants.previewImageSizeHeight
        )
        .fullScreenCover(isPresented: $viewModel.isDetailedStoryViewPresented) {
            StoriesView(
                stories: $stories,
                currentStoryIndex: $viewModel.storyIndex,
                isDetailedStoryViewPresented: $viewModel.isDetailedStoryViewPresented
            )
        }
        .onTapGesture {
            impactMed.impactOccurred()
            viewModel.detailedStoryViewPresentation(stories: stories, story: story)
        }
    }
}

struct StoriesRowPreview: View {
    @State var stories = StoryFactory().stories

    var body: some View {
        StoriesRowView(stories: $stories, story: $stories[2])
    }
}

#Preview {
    StoriesRowPreview()
}
