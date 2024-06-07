//
//  OnboardingCoordinator.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI
import Combine

class OnboardingCoordinator: ObservableObject {
    @Published var onboardingViewModel: OnboardingViewModel
    
    let didFinishOnboarding = PassthroughSubject<Void, Never>()
    
    init(diContainer: DIContainer) {
//        self.countrySelectionViewModel = CountrySelectionViewModel(fetchCountriesUseCase: diContainer.fetchCountriesUseCase)
//        self.categorySelectionViewModel = CategorySelectionViewModel(fetchCategoriesUseCase: diContainer.fetchCategoriesUseCase)
        self.onboardingViewModel = OnboardingViewModel(
            fetchCountriesUseCase: diContainer.fetchCountriesUseCase,
            fetchCategoriesUseCase: diContainer.fetchCategoriesUseCase,
            realmManager: diContainer.realmManager)
    }
    
    func finishOnboarding() {
        didFinishOnboarding.send()
    }
}
