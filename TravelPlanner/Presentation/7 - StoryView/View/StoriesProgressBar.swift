//
//  StoriesProgressBar.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 11.12.2024.
//

import SwiftUI
import Combine

struct StoriesProgressBar: View {
    // MARK: - Constants

    let storiesCount: Int
    let timerConfiguration: TimerConfiguration

    // MARK: - Public Properties

    @Binding var currentProgress: CGFloat

    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: currentProgress)
            .padding(.init(top: 7, leading: 12, bottom: 12, trailing: 12))
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
    }

    // MARK: - Private Properties

    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?

    // MARK: - Initializers

    init(storiesCount: Int, timerConfiguration: TimerConfiguration, currentProgress: Binding<CGFloat>) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration)
    }

    // MARK: - Private Methods

    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }

    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

struct StoriesProgressBarPreview: View {
    let storiesCount = 5
    @State var currentProgress: CGFloat = 0
    private var timerConfiguration: TimerConfiguration { .init(storiesCount: storiesCount) }

    var body: some View {
        StoriesProgressBar(
            storiesCount: storiesCount,
            timerConfiguration: timerConfiguration,
            currentProgress: $currentProgress
        )
    }
}

#Preview {
    Color.orange
        .ignoresSafeArea()
        .overlay {
            StoriesProgressBarPreview()
        }
}
