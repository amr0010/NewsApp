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
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: OnboardingViewModel) {
        self.onboardingViewModel = viewModel
        setupBindings()
    }
    
    func finishOnboarding() {
        didFinishOnboarding.send()
    }
    
    private func setupBindings() {
           onboardingViewModel.onboardingCompleted
               .sink { [weak self] in
                   print("Onboarding completed signal received")
                   self?.didFinishOnboarding.send()
               }
               .store(in: &cancellables)
       }
}
