//
//  FetchHeadlinesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol FetchHeadlinesUseCaseProtocol {
    func execute(onboardingEntity: OnboardingEntity) -> AnyPublisher<[ArticleEntity], APIError>
}

class FetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol {
    private let repository: ArticlesRepositoryProtocol

    init(repository: ArticlesRepositoryProtocol) {
        self.repository = repository
    }

    func execute(onboardingEntity: OnboardingEntity) -> AnyPublisher<[ArticleEntity], APIError> {
        return repository.fetchHeadlines(onboardingEntity: onboardingEntity)
    }
}
