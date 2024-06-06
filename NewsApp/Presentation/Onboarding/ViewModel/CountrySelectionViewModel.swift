//
//  CategorySelectionViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import Foundation
import Combine

class CountrySelectionViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var filteredCountries: [Country] = []
    @Published var selectedCountry: Country?
    @Published var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    @Published var errorMessage: String?

    private let fetchCountriesUseCase: FetchCountriesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(fetchCountriesUseCase: FetchCountriesUseCaseProtocol) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        loadCountries()
    }

    func loadCountries() {
        fetchCountriesUseCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { countries in
                self.countries = countries
                self.filteredCountries = countries
            })
            .store(in: &cancellables)
    }

    func selectCountry(_ country: Country) {
        selectedCountry = country
    }

    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
