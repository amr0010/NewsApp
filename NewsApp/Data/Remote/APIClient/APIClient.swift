//
//  APIClient.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//


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
        guard let url = endpoint.url else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = endpoint.body

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    debugPrint("ERROR \(response)")
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

