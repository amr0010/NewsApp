//
//  FetchCategoriesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol FetchCategoriesUseCaseProtocol {
    func execute(apiKey: String) -> AnyPublisher<[String], Error>
}

class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    private let repository: CategoriesRepositoryProtocol

    init(repository: CategoriesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(apiKey: String) -> AnyPublisher<[String], Error> {
        return repository.fetchCategories(apiKey: apiKey)
    }
}
