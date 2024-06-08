//
//  OnboardingCoordinator.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI
import Combine

class OnboardingCoordinator: ObservableObject {
    
    let didFinishOnboarding = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
    }
    
    func finishOnboarding() {
        didFinishOnboarding.send()
    }
    
}
