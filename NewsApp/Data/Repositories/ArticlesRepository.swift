//
//  ArticlesRepository.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol ArticlesRepositoryProtocol {
    func fetchHeadlines(onboardingEntity: OnboardingEntity, categories: [String]) -> AnyPublisher<[ArticleEntity], APIError>
    func searchArticles(query: String) -> AnyPublisher<[ArticleEntity], APIError>
    func saveArticle(_ article: ArticleEntity) -> AnyPublisher<Void, APIError>
    func fetchSavedArticles() -> AnyPublisher<[ArticleEntity], APIError>
    func deleteArticle(_ article: ArticleEntity) -> AnyPublisher<Void, APIError>
    
}

class ArticlesRepository: ArticlesRepositoryProtocol {
    private let remoteDataSource: RemoteDataSource
    private let mapper: ArticleMapper
    private let realmManager: RealmManagerProtocol
    
    init(remoteDataSource: RemoteDataSource, mapper: ArticleMapper, realmManager: RealmManagerProtocol) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
        self.realmManager = realmManager
    }
    
    func fetchHeadlines(onboardingEntity: OnboardingEntity, categories: [String]) -> AnyPublisher<[ArticleEntity], APIError> {
            let publishers = categories.map { category in
                remoteDataSource.fetchHeadlines(onboardingEntity: onboardingEntity, category: category)
                    .map { response in
                        self.mapper.mapToEntity(from: response.articles ?? [])
                    }
                    .eraseToAnyPublisher()
            }
        return Publishers.MergeMany(publishers)
            .collect()
            .map { $0.flatMap { $0 } }
            .map { articles in
                articles.sorted(by: { $0.publishedAt > $1.publishedAt })
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
    
    func saveArticle(_ article: ArticleEntity) -> AnyPublisher<Void, APIError> {
        let realmArticleEntity = RealmArticleEntity(article: article)
        return Future<Void, APIError> { promise in
            do {
                try self.realmManager.add(realmArticleEntity)
                promise(.success(()))
            } catch {
                promise(.failure(.localDBError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchSavedArticles() -> AnyPublisher<[ArticleEntity], APIError> {
        return Future<[ArticleEntity], APIError> { promise in
            do {
                let realmArticles = try self.realmManager.getAll(RealmArticleEntity.self)
                let articles = realmArticles.map { $0.articleEntity }
                promise(.success(articles))
            } catch {
                promise(.failure(.localDBError))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteArticle(_ article: ArticleEntity) -> AnyPublisher<Void, APIError> {
        let realmArticleEntity = RealmArticleEntity(article: article)
        return Future<Void, APIError> { promise in
            do {
                try self.realmManager.delete(realmArticleEntity)
                promise(.success(()))
            } catch {
                promise(.failure(.localDBError))
            }
        }
        .eraseToAnyPublisher()
    }
}
