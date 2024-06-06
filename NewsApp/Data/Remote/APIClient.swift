//
//  APIClient.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

enum APIClientError: Error {
    case invalidURL
    case responseError
    case decodingError
}

class APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, APIClientError> {
        return session.dataTaskPublisher(for: url)
            .mapError { _ in APIClientError.responseError }
            .flatMap { data, response -> AnyPublisher<T, APIClientError> in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return Fail(error: APIClientError.responseError).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { _ in APIClientError.decodingError }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func fetchCategories(apiKey: String) -> AnyPublisher<[String], APIClientError> {
        return Just(["Category1", "Category2", "Category3"])
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
}
