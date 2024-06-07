//
//  NewsAPIEndpoint.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct NewsAPIEndpoint: Endpoint {
    var url: URL?
    var method: HTTPMethod
    var headers: [String: String]?
    var body: Data?

    init(path: String, queryItems: [URLQueryItem] = [], method: HTTPMethod = .get, headers: [String: String]? = nil, body: Data? = nil) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Constants.API.newsAPIHost
        components.path = path
        components.queryItems = queryItems
        self.url = components.url
        self.method = method
        self.headers = headers
        self.body = body
    }

    func asURLRequest() -> URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpBody = body
        return request
    }
}
