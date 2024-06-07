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
        self.onboardingViewModel = OnboardingViewModel(
            fetchCountriesUseCase: diContainer.fetchCountriesUseCase,
            fetchCategoriesUseCase: diContainer.fetchCategoriesUseCase,
            onboardingUseCase: diContainer.onboardingUseCase)
    }
    
    func finishOnboarding() {
        didFinishOnboarding.send()
    }
}
