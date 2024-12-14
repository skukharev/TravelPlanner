//
//  AppSettings.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 05.11.2024.
//

import SwiftUI

final class AppSettings: ObservableObject {
    // MARK: - Constants

    private enum Constants {
        static let useDarkThemeKey = "useDarkTheme"
        static let storiesIsViewedKey = "storiesIsViewed"
    }

    // MARK: - Public Properties

    @AppStorage(Constants.useDarkThemeKey)
    var isDarkMode: Bool?

    // MARK: - Private Properties

    @AppStorage(Constants.storiesIsViewedKey)
    private var storiesIsViewed: String?
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()

    // MARK: - Public Methods

    func loadAppVersion() -> String {
        guard
            let nsObject = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? AnyObject,
            let appVersion = nsObject as? String
        else {
            return ""
        }
        return appVersion
    }

    func saveStoryIsViewedStatus(storyId: UUID, isViewed: Bool) {
        var storiesIsViewedStatuses = loadStoryIsViewedStatuses()
        if let storyIndex = storiesIsViewedStatuses.firstIndex(where: { $0.id == storyId }) {
            storiesIsViewedStatuses[storyIndex].isViewed = isViewed
        } else {
            storiesIsViewedStatuses.append(StoryViewStatus(id: storyId, isViewed: isViewed))
        }
        guard
            let data = try? encoder.encode(storiesIsViewedStatuses),
            let jsonString = String(data: data, encoding: .utf8)
        else {
            return
        }
        storiesIsViewed = jsonString
    }

    func loadStoryIsViewedStatuses() -> [StoryViewStatus] {
        guard
            let jsonData = storiesIsViewed?.data(using: .utf8),
            let storiesIsViewedStatuses = try? decoder.decode([StoryViewStatus].self, from: jsonData)
        else { return [] }

        return storiesIsViewedStatuses
    }
}
