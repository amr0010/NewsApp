//
//  ArticlesRepository.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol ArticlesRepositoryProtocol {
    func fetchHeadlines(onboardingEntity: OnboardingEntity) -> AnyPublisher<[ArticleEntity], APIError>
    func searchArticles(query: String) -> AnyPublisher<[ArticleEntity], APIError>

}

class ArticlesRepository: ArticlesRepositoryProtocol {
    private let remoteDataSource: RemoteDataSource
    private let mapper: ArticleMapper

    init(remoteDataSource: RemoteDataSource, mapper: ArticleMapper) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    func fetchHeadlines(onboardingEntity: OnboardingEntity) -> AnyPublisher<[ArticleEntity], APIError> {
        
        return remoteDataSource.fetchHeadlines(onboardingEntity: onboardingEntity)
            .map { response in
                self.mapper.mapToEntity(from: response.articles ?? [])
            }
            .eraseToAnyPublisher()
    }
    
    func searchArticles(query: String) -> AnyPublisher<[ArticleEntity], APIError> {
           return remoteDataSource.searchArticles(query: query)
               .map { response in
                   self.mapper.mapToEntity(from: response.articles ?? [])
               }
               .eraseToAnyPublisher()
       }
}
