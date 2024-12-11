//
//  Constants.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 04.10.2024.
//
import SwiftUI

typealias ObjectNotFoundErrorResponse = Components.Schemas.ObjectNotFoundErrorResponse

struct ObjectNotFoundError: Error {
    let response: ObjectNotFoundErrorResponse
}

struct ResponseOtherError: Error {
    let response: String
}

enum GlobalConstants {
    static let yandexMetrikaApi = "b61e3503-20ad-4535-8800-9608caf9b514"
    static let yandexSchedulesApi = "ff0eaf80-755e-4f8e-a0d2-637083058654"
    static let ypRegular12: Font = .system(size: 12, weight: .regular, design: .default)
    static let ypRegular17: Font = .system(size: 17, weight: .regular, design: .default)
    static let ypRegular20: Font = .system(size: 20, weight: .regular, design: .default)
    static let ypBold17: Font = .system(size: 17, weight: .bold, design: .default)
    static let ypBold24: Font = .system(size: 24, weight: .bold, design: .default)
    static let ypBold34: Font = .system(size: 34, weight: .bold, design: .default)
    static let defaultCornerRadius: CGFloat = 16
    static let RussianFederationId = "l225"
    static let searchBarMagnifyingGlassImageName = "magnifyingglass"
    static let searchBarClearSearchTextImageName = "xmark.circle.fill"
    static let searchBarCornerRadius: CGFloat = 10.0
    static let searchBarPaddingInsets = EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
    static let listNavigationLinkImageName = "chevron.right"
    static let defaultVerticalSpacing: CGFloat = 16
}
