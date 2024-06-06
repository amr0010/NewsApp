//
//  RemoteDataSource.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

class RemoteDataSource {
    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func fetchCategories(apiKey: String) -> AnyPublisher<[String], Error> {
        //TODO: - use APIClient to get categories

        let categories = ["Category1", "Category2", "Category3"]
            return Just(categories)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        
    }
}
