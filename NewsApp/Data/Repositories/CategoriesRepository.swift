//
//  CategoriesRepository.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol CategoriesRepositoryProtocol {
    func fetchCategories(apiKey: String) -> AnyPublisher<[String], Error>
}

class CategoriesRepository: CategoriesRepositoryProtocol {
    private let remoteDataSource: RemoteDataSource

    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchCategories(apiKey: String) -> AnyPublisher<[String], Error> {
        return remoteDataSource.fetchCategories(apiKey: apiKey)
    }
}

