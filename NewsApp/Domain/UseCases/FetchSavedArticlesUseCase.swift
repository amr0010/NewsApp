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
    private let repository: ArticlesRepositoryProtocol
    
    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[ArticleEntity], APIError> {
        return repository.fetchSavedArticles()
    }
}
