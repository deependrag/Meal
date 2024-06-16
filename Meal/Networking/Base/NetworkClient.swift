//
//  NetworkClient.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Foundation
class NetworkClient {
    static func executeRequest<T: Decodable, R: Request>(url: String = NetworkConstants.baseURL, _ request: R) async throws -> T {
        guard let urlRequest = request.asURLRequest(baseURL: url) else {
            throw NetworkError.invalidRequest
        }
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
