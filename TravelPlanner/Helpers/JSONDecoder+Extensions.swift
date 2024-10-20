//
//  JSONDecoder+Extensions.swift
//  TravelPlanner
//
//  Created by Сергей Кухарев on 20.10.2024.
//

import Foundation
import OpenAPIRuntime

extension JSONDecoder {
    func decode<T: Decodable>(from httpBody: HTTPBody, to type: T.Type, upTo maxBytes: Int = 100 * 1024 * 1024) async throws -> T {
        let data = try await Data(collecting: httpBody, upTo: maxBytes)
        return try self.decode(T.self, from: data)
    }
}
