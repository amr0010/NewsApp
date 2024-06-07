//
//  SearchArticlesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol SearchArticlesUseCaseProtocol {
    func execute(query: String) -> AnyPublisher<[ArticleEntity], APIError>
}

class SearchArticlesUseCase: SearchArticlesUseCaseProtocol {
    private let repository: ArticlesRepositoryProtocol

    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) -> AnyPublisher<[ArticleEntity], APIError> {
        return repository.searchArticles(query: query)
    }
}
