//
//  FetchSavedArticlesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol FetchSavedArticlesUseCaseProtocol {
    func execute() -> AnyPublisher<[ArticleEntity], APIError>
}

class FetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol {
    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func execute() -> AnyPublisher<[ArticleEntity], APIError> {
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
   }
