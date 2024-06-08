//
//  SaveArticleUseCaseProtocol.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Combine

protocol SaveArticleUseCaseProtocol {
    func execute(article: ArticleEntity) -> AnyPublisher<Void, APIError>
}

class SaveArticleUseCase: SaveArticleUseCaseProtocol {
    private let repository: ArticlesRepositoryProtocol

      init(repository: ArticlesRepositoryProtocol) {
          self.repository = repository
      }

    func execute(article: ArticleEntity) -> AnyPublisher<Void, APIError> {
           return repository.saveArticle(article)
       }
}
