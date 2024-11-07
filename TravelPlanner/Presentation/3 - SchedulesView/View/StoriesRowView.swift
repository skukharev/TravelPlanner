//
//  StoriesRowView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 07.11.2024.
//

import SwiftUI

struct StoriesRowView: View {
    private enum Constants {
        static let previewImageSizeWidth: CGFloat = 92
        static let previewImageSizeHeight: CGFloat = 140
        static let previewImageCornerRadius: CGFloat = 16
        static let previewImageBorderColor: Color = .blueUniversal
        static let previewImageBorderWidth: CGFloat = 4
        static let titleFont = GlobalConstants.ypRegular12
        static let titleColor: Color = .white
        static let titleLinesCount = 3
        static let titleWidth: CGFloat = 76
        static let titleHeight: CGFloat = 45
        static let titleVerticalOffsetRelationToImage: CGFloat = 36
        static let notViewedRowOpacity: CGFloat = 0.5
    }

    var story: Story

    var body: some View {
        ZStack {
            Image(uiImage: story.previewImage)
                .resizable()
                .scaledToFit()
                .opacity(Double(story.isViewed ? 1 : 0.5))
                .border(
                    story.isViewed ? Constants.previewImageBorderColor : Color.clear,
                    width: story.isViewed ? Constants.previewImageBorderWidth : 0
                )
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
            Text(story.title)
                .font(Constants.titleFont)
                .foregroundStyle(Constants.titleColor)
                .frame(
                    width: Constants.titleWidth,
                    height: Constants.titleHeight
                )
                .lineLimit(Constants.titleLinesCount)
                .offset(y: Constants.titleVerticalOffsetRelationToImage)
                .opacity(Double(story.isViewed ? 1 : Constants.notViewedRowOpacity))
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
            isViewed: true
        )
    )
}
