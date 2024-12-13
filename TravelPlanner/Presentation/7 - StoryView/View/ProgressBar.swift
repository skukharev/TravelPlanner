//
//  ProgressBar.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 10.12.2024.
//

import SwiftUI

struct ProgressBar: View {
    // MARK: - Constants

    enum Constants {
        static let progressBarCornerRadius: CGFloat = 3
        static let progressBarHeight: CGFloat = 6
        static let progressBarBackgroundColor: Color = .white
        static let progressBarForegroundColor: Color = .blueUniversal
    }
    let numberOfSections: Int
    let progress: CGFloat

    // MARK: - Public Properties

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: Constants.progressBarHeight)
                    .foregroundColor(Constants.progressBarBackgroundColor)

                RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: Constants.progressBarHeight
                    )
                    .foregroundColor(Constants.progressBarForegroundColor)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    let numberOfSections: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    // MARK: - Constants

    enum Constants {
        static let progressBarCornerRadius: CGFloat = 3
        static let progressBarHeight: CGFloat = 6
        static let progressBarBackgroundColor: Color = .white
        static let progressBarForegroundColor: Color = .blueUniversal
    }

    // MARK: - Public Properties

    var body: some View {
        RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: Constants.progressBarHeight)
            .foregroundStyle(Constants.progressBarBackgroundColor)
    }
}

#Preview {
    Color.pink
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}
