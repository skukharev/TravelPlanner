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

    // MARK: - Public Properties

    var story: Story

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
    }
}

#Preview {
    StoriesRowView(
        story: Story(
            previewImage: Asset.Images.Stories.story1Preview.image,
            images: [Asset.Images.Stories.story1Detail1.image, Asset.Images.Stories.story1Detail2.image],
            title: "Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            isViewed: false
        )
    )
}
