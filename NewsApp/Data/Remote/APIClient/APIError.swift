//
//  APIError.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case responseError
    case decodingError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .responseError:
            return "Response error"
        case .decodingError:
            return "Decoding error"
        case .unknownError:
            return "Unknown error"
        }
    }
}
