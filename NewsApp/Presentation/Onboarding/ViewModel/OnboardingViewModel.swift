//
//  OnboardingViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Combine
import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var selectedCountry: CountryEntity?
    @Published var selectedCategories: [CategoryEntity] = []
    @Published var canFinishOnboarding: Bool = false
    @Published var canProceedToCategories: Bool = false
    @Published var countries: [CountryEntity] = []
    @Published var filteredCountries: [CountryEntity] = []
    @Published var categories: [CategoryEntity] = []
    @Published var errorMessage: String?
    @Published var searchText: String = "" {
        didSet {
            filterCountries()
        }
    }
    
    let onboardingCompleted = PassthroughSubject<Void, Never>()
    private let fetchCountriesUseCase: FetchCountriesUseCaseProtocol
    private let fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol
    private let onboardingUseCase: OnboardingUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    // Initializer to set use cases and realm manager
    init(fetchCountriesUseCase: FetchCountriesUseCaseProtocol, fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol, onboardingUseCase: OnboardingUseCaseProtocol) {
        self.fetchCountriesUseCase = fetchCountriesUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.onboardingUseCase = onboardingUseCase

        // Enable the Next button if at least 3 categories are selected
        $selectedCategories
            .map { $0.count >= 3 }
            .assign(to: &$canFinishOnboarding)
        
        // Enable the Next button in country selection if a country is selected
        $selectedCountry
            .map { $0 != nil }
            .assign(to: &$canProceedToCategories)
    }

    // Load countries using the fetchCountriesUseCase
    func loadCountries() {
        fetchCountriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error loading countries: \(error.localizedDescription)")
                }
            }, receiveValue: { countries in
                self.countries = countries
                self.filteredCountries = countries
            })
            .store(in: &cancellables)
    }

    // Load categories using the fetchCategoriesUseCase
    func loadCategories() {
        fetchCategoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("Error loading categories: \(error.localizedDescription)")
                }
            }, receiveValue: { categories in
                self.categories = categories
                print("Categories loaded: \(categories)")
            })
            .store(in: &cancellables)
    }

    // Filter countries based on searchText
    private func filterCountries() {
        if searchText.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    // Select or deselect a category
    func selectCategory(_ category: CategoryEntity) {
        if selectedCategories.contains(where: { $0.id == category.id }) {
            selectedCategories.removeAll { $0.id == category.id }
        } else {
            selectedCategories.append(category)
        }
    }

    // Select a country
    func selectCountry(_ country: CountryEntity) {
        selectedCountry = country
    }
    
    func finishOnboarding() {
        saveOnboardingData()
    }

    // Save onboarding data using the onboardingUseCase
    private func saveOnboardingData() {
        guard let selectedCountry = selectedCountry else { return }

        onboardingUseCase.saveOnboardingData(selectedCountry: selectedCountry, selectedCategories: selectedCategories)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: {
                print("success")
                self.onboardingCompleted.send()
            })
            .store(in: &cancellables)
    }
}
