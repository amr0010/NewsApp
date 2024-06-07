//
//  FetchCategoriesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol FetchCategoriesUseCaseProtocol {
    func execute() -> AnyPublisher<[CategoryEntity], Error>
}

class FetchCategoriesUseCase: FetchCategoriesUseCaseProtocol {
    private let repository: CategoriesRepositoryProtocol
    
    init(repository: CategoriesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[CategoryEntity], Error> {
        return repository.fetchCategories()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
