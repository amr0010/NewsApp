//
//  RemoteDataSource.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

class RemoteDataSource {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchCategories() -> AnyPublisher<SourcesResponseDTO, APIError> {
        let endpoint = NewsAPIEndpoint(
            path: Constants.API.sourcesPath,
            queryItems: [URLQueryItem(name: "apiKey", value: Constants.API.apiKey)]
        )
        return apiClient.fetch(endpoint: endpoint)
            
    }
    
}

