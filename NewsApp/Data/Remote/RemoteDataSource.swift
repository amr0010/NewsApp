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
    
    func fetchHeadlines(onboardingEntity: OnboardingEntity, category: String) -> AnyPublisher<ArticlesResponseDTO, APIError> {
            let endpoint = ArticlesAPIEndpoint(
                path: Constants.API.articlesPath,
                queryItems: [
                    URLQueryItem(name: "country", value: onboardingEntity.selectedCountry),
                    URLQueryItem(name: "category", value: category),
                    URLQueryItem(name: "apiKey", value: Constants.API.apiKey)
                ]
            )
            return apiClient.fetch(endpoint: endpoint)
        }
    
    func searchArticles(query: String) -> AnyPublisher<ArticlesResponseDTO, APIError> {
            let endpoint = ArticlesAPIEndpoint(
                path: Constants.API.everythingPath,
                queryItems: [
                    URLQueryItem(name: "q", value: query),
                    URLQueryItem(name: "apiKey", value: Constants.API.apiKey)
                ]
            )
            return apiClient.fetch(endpoint: endpoint)
        }
}

