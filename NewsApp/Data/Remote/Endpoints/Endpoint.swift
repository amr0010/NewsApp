//
//  Endpoint.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }

    func asURLRequest() -> URLRequest?
}
