//
//  CountrySelectionViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import Foundation
import Combine

class CategorySelectionViewModel: ObservableObject {
    @Published var categories: [String] = []
    @Published var selectedCategories: [String] = []
    @Published var errorMessage: String?

    private let fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }

    func loadCategories(apiKey: String) {
        fetchCategoriesUseCase.execute(apiKey: apiKey)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
    }

    func selectCategory(_ category: String) {
        if selectedCategories.contains(category) {
            selectedCategories.removeAll { $0 == category }
        } else {
            selectedCategories.append(category)
        }
    }
}


