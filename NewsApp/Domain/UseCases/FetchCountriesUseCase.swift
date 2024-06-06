//
//  FetchCountriesUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol FetchCountriesUseCaseProtocol {
    func execute() -> AnyPublisher<[Country], Never>
}

class FetchCountriesUseCase: FetchCountriesUseCaseProtocol {
    private let repository: CountriesRepositoryProtocol

    init(repository: CountriesRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[Country], Never> {
        return repository.fetchCountries()
    }
}
