//
//  ErrorViewType.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 23.11.2024.
//

enum ErrorViewType: Error {
    case noInternetError
    case serverError

    func imageAsset() -> ImageAsset {
        switch self {
        case .noInternetError:
            return Asset.Images.noInternetError
        case .serverError:
            return Asset.Images.serverError
        }
    }

    func errorDescription() -> String {
        switch self {
        case .noInternetError:
            return L10n.errorNoInternet
        case .serverError:
            return L10n.errorServerError
        }
    }
}
