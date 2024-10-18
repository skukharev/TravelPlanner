//
//  Constants.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 04.10.2024.
//

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
}
