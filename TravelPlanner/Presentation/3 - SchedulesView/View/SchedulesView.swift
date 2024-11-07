//
//  SchedulesView.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 30.10.2024.
//

import SwiftUI

struct SchedulesView: View {
    // MARK: - Types

    private enum Constants {
        static let storiesSpacing: CGFloat = 12
        static let storiesHeight: CGFloat = 188
    }

    // MARK: - Constants

    let rows = [GridItem(.flexible())]

    // MARK: - Public Properties

    @StateObject var viewModel = SchedulesViewModel()

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center, spacing: Constants.storiesSpacing) {
                    ForEach(viewModel.stories) { story in
                        StoriesRowView(story: story)
                    }
                }
                .frame(maxHeight: Constants.storiesHeight)
            }
            .padding()
            Spacer()
            Divider()
        }
    }
}

#Preview {
    SchedulesView()
}
