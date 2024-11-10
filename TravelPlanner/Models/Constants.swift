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
    static let ypBold24: Font = .system(size: 24, weight: .bold, design: .default)
    static let defaultCornerRadius: CGFloat = 16
}
