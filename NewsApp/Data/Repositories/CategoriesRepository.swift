//
//  CategoriesRepository.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol CategoriesRepositoryProtocol {
    func fetchCategories() -> AnyPublisher<[CategoryEntity], APIError>
}

class CategoriesRepository: CategoriesRepositoryProtocol {
    private let remoteDataSource: RemoteDataSource
    private let mapper: CategoryMapper

    init(remoteDataSource: RemoteDataSource, mapper: CategoryMapper) {
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }

    func fetchCategories() -> AnyPublisher<[CategoryEntity], APIError> {
        return remoteDataSource.fetchCategories()
            .map { response in
                let entities = self.mapper.mapToEntity(from: response)
                let uniqueCategories = Array(Set(entities.map { $0.name })).map { name in
                    entities.first { $0.name == name }!
                }
                return uniqueCategories
            }
            .eraseToAnyPublisher()
    }
}
