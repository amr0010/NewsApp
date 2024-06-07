//
//  CountrySelectionViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import Foundation
import Combine

class CategorySelectionViewModel: ObservableObject {
    @Published var categories: [CategoryEntity] = []
    @Published var selectedCategories: [CategoryEntity] = []
    @Published var errorMessage: String?

    private let fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(fetchCategoriesUseCase: FetchCategoriesUseCaseProtocol) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
    }

    func loadCategories() {
        fetchCategoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { categories in
                self.categories = categories
            })
            .store(in: &cancellables)
    }

    func selectCategory(_ category: CategoryEntity) {
        if selectedCategories.contains(where: { $0.id == category.id }) {
            selectedCategories.removeAll { $0.id == category.id }
        } else {
            selectedCategories.append(category)
        }
    }
}



