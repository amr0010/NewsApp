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
                return self.mapper.mapToEntity(from: response)
            }
            .eraseToAnyPublisher()
    }
}
