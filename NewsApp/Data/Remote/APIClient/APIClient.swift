//
//  APIClient.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

import Combine
import Foundation

protocol APIClientProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError>
}

class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError> {
        guard let request = endpoint.asURLRequest() else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.responseError
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return APIError.decodingError
                } else if error is URLError {
                    return APIError.responseError
                } else {
                    return APIError.unknownError
                }
            }
            .eraseToAnyPublisher()
    }
}
