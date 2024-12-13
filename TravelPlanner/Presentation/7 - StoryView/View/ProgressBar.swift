//
//  ProgressBar.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 10.12.2024.
//

import SwiftUI

struct ProgressBar: View {
    // MARK: - Types

    private enum Constants {
        static let progressBarCornerRadius: CGFloat = 3
        static let progressBarHeight: CGFloat = 6
        static let progressBarBackgroundColor: Color = .white
        static let progressBarForegroundColor: Color = .blueUniversal
    }

    // MARK: - Constants

    let numberOfSections: Int
    let progress: CGFloat

    // MARK: - Public Properties

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: Constants.progressBarHeight)
                    .foregroundStyle(Constants.progressBarBackgroundColor)

                RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: Constants.progressBarHeight
                    )
                    .foregroundStyle(Constants.progressBarForegroundColor)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

private struct MaskView: View {
    // MARK: - Constants

    let numberOfSections: Int

    // MARK: - Public Properties

    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

private struct MaskFragmentView: View {
    // MARK: - Types

    private enum Constants {
        static let progressBarCornerRadius: CGFloat = 3
        static let progressBarHeight: CGFloat = 6
    }

    // MARK: - Public Properties

    var body: some View {
        RoundedRectangle(cornerRadius: Constants.progressBarCornerRadius)
            .frame(height: Constants.progressBarHeight)
            .foregroundStyle(Color.white)
    }
}

#Preview {
    Color.orange
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}

#Preview("MaskFragmentView") {
    Color.orange
        .overlay {
            MaskFragmentView()
                .padding()
        }
        .ignoresSafeArea()
}

#Preview("MaskView") {
    Color.orange
        .overlay {
            MaskView(numberOfSections: 5)
                .padding()
        }
}
