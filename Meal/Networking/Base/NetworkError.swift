//
//  NetworkError.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Foundation

enum NetworkError: Error {
    case requestFailed(Error)
    case invalidURL
    case invalidData
    case invalidRequest
    case serverError
    case decodingError
}
