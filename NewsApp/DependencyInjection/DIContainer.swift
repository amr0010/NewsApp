//
//  DIContainer.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import Foundation

class DIContainer {
    static let shared = DIContainer()

    private init() {}

    lazy var apiClient: APIClient = {
        APIClient()
    }()

    lazy var remoteDataSource: RemoteDataSource = {
        RemoteDataSource(apiClient: apiClient)
    }()

    lazy var realmManager: RealmManager = {
        RealmManager()
    }()

    lazy var localDataSource: LocalDataSource = {
        LocalDataSource(realmManager: realmManager)
    }()
    
    lazy var countryManager: CountryManager = {
        CountryManager.shared
    }()
    
    lazy var countriesRepository: CountriesRepositoryProtocol = {
        CountriesRepository(countryManager: countryManager)
    }()
    
    lazy var categoriesRepository: CategoriesRepositoryProtocol = {
        CategoriesRepository(remoteDataSource: remoteDataSource)
    }()

    lazy var fetchCountriesUseCase: FetchCountriesUseCaseProtocol = {
        FetchCountriesUseCase(repository: countriesRepository)
    }()

    lazy var fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol = {
        FetchCategoriesUseCase(repository: categoriesRepository)
    }()
}
