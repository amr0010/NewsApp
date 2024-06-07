//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI
import Combine

class AppCoordinator: ObservableObject {
    @Published var onboardingCoordinator: OnboardingCoordinator?
    @Published var headlinesCoordinator: HeadlinesCoordinator?

    private var cancellables = Set<AnyCancellable>()
    private let diContainer: DIContainer
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
        if !UserDefaults.standard.bool(forKey: Constants.Preferences.onboardingCompletedKey) {
            startOnboarding()
        } else {
            startHeadlines()
        }
    }
    
    func start() {
        if !UserDefaults.standard.bool(forKey: Constants.Preferences.onboardingCompletedKey) {
            startOnboarding()
        } else {
            startHeadlines()
        }
    }
    
    private func startOnboarding() {
        let onboardingViewModel = OnboardingViewModel(
                   fetchCountriesUseCase: diContainer.fetchCountriesUseCase,
                   fetchCategoriesUseCase: diContainer.fetchCategoriesUseCase,
                   onboardingUseCase: diContainer.onboardingUseCase
               )
        onboardingCoordinator = OnboardingCoordinator(viewModel: onboardingViewModel)
        onboardingCoordinator?.didFinishOnboarding
            .sink(receiveValue: { [weak self] in
                self?.finishOnboarding()
            })
            .store(in: &cancellables)
    }
    
    private func startHeadlines() {
        let headlinesViewModel = HeadlinesViewModel(fetchHeadlinesUseCase: diContainer.fetchHeadlinesUseCase, onboardingUseCase: diContainer.onboardingUseCase)
        headlinesCoordinator = HeadlinesCoordinator(headlinesViewModel: headlinesViewModel)
    }
    
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: Constants.Preferences.onboardingCompletedKey)
        onboardingCoordinator = nil
        startHeadlines()
    }
}
