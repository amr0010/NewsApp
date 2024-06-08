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

    lazy var apiClient: APIClientProtocol = {
        APIClient()
    }()

    lazy var remoteDataSource: RemoteDataSource = {
        RemoteDataSource(apiClient: apiClient)
    }()

    lazy var realmManager: RealmManagerProtocol = {
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
    
    lazy var categoryMapper: CategoryMapper = {
        CategoryMapper()
    }()
    
    lazy var articleMapper: ArticleMapper = {
        ArticleMapper()
    }()
    
    lazy var categoriesRepository: CategoriesRepositoryProtocol = {
        CategoriesRepository(remoteDataSource: remoteDataSource, mapper: categoryMapper)
    }()
    
    lazy var articleRepository: ArticlesRepositoryProtocol = {
        ArticlesRepository(remoteDataSource: remoteDataSource, mapper: articleMapper)
    }()

    lazy var fetchCountriesUseCase: FetchCountriesUseCaseProtocol = {
        FetchCountriesUseCase(repository: countriesRepository)
    }()

    lazy var fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol = {
        FetchCategoriesUseCase(repository: categoriesRepository)
    }()
    
    lazy var onboardingUseCase: OnboardingUseCaseProtocol = {
        OnboardingUseCase(realmManager: realmManager)
    }()
    
    lazy var saveArticleUseCase: SaveArticleUseCaseProtocol = {
        SaveArticleUseCase(realmManager: realmManager)
    }()
    
    lazy var fetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol = {
        FetchSavedArticlesUseCase(realmManager: realmManager)
    }()
    
    lazy var searchArticlesUseCase: SearchArticlesUseCase = {
        SearchArticlesUseCase(repository: articleRepository)
    }()
    
    lazy var fetchHeadlinesUseCase: FetchHeadlinesUseCase = {
        FetchHeadlinesUseCase(repository: articleRepository)
    }()
    
    lazy var deleteSavedArticleUseCase: DeleteSavedArticleUseCase = {
        DeleteSavedArticleUseCase(realmManager: realmManager)
    }()
    
}
