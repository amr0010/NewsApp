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
    
    init() {
        if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            startOnboarding()
        } else {
            startHeadlines()
        }
    }
    
    func start() {
        if !UserDefaults.standard.bool(forKey: "hasCompletedOnboarding") {
            startOnboarding()
        } else {
            startHeadlines()
        }
    }
    
    private func startOnboarding() {
        onboardingCoordinator = OnboardingCoordinator()

    }
    
    private func startHeadlines() {
        headlinesCoordinator = HeadlinesCoordinator()
    }
    
    func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
        onboardingCoordinator = nil
        startHeadlines()
    }
}
