//
//  CountriesRepository.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import Combine

protocol CountriesRepositoryProtocol {
    func fetchCountries() -> AnyPublisher<[CountryEntity], Never>
}

class CountriesRepository: CountriesRepositoryProtocol {
    private let countryManager: CountryManager
    
    
    init(countryManager: CountryManager = .shared) {
        self.countryManager = countryManager
    }
    
    func fetchCountries() -> AnyPublisher<[CountryEntity], Never> {
        let countries = countryManager.getAllCountries()
        return Just(countries).eraseToAnyPublisher()
    }
}
