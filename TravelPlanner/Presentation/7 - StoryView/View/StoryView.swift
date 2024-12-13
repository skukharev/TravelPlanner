//
//  StoryView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 09.12.2024.
//

import SwiftUI

struct StoryView: View {
    // MARK: - Constants

    enum Constants {
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

    // MARK: - Public Properties

    var story: Story

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
                                .scaleEffect(viewInFinalState ? 1 : Constants.textElementsStartingScaleValue)
                                .animation(.easeInOut(duration: Constants.animationDuration), value: viewInFinalState)
                            Text(story.description)
                                .font(Constants.storyDescriptionFont)
                                .lineLimit(3)
                                .foregroundColor(Constants.textElementsColor)
                                .scaleEffect(viewInFinalState ? 1 : Constants.textElementsStartingScaleValue)
                                .animation(.easeInOut(duration: Constants.animationDuration), value: viewInFinalState)
                        }
                        .padding(Constants.textElementsPadding)
                    }
                }
            }
            .onAppear {
                viewInFinalState = true
            }
    }

    // MARK: - Private Properties

    @State private var viewInFinalState = false
}

struct StoryPreview: View {
    private var story = StoryFactory().stories[0]

    var body: some View {
        StoryView(story: story)
    }
}

#Preview {
    StoryPreview()
}
