//
//  DeleteSavedArticleUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 08/06/2024.
//

import Foundation
import Combine

protocol DeleteSavedArticleUseCaseProtocol {
    func execute(article: ArticleEntity) -> AnyPublisher<Void, APIError>
}

class DeleteSavedArticleUseCase: DeleteSavedArticleUseCaseProtocol {
    private let repository: ArticlesRepositoryProtocol

    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(article: ArticleEntity) -> AnyPublisher<Void, APIError> {
        return repository.deleteArticle(article)
    }
}

