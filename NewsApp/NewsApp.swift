//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

@main
struct NewsApp: App {
    @ObservedObject private var appCoordinator = AppCoordinator(diContainer: DIContainer.shared)

    var body: some Scene {
        WindowGroup {
            Group {
                if let onboardingCoordinator = appCoordinator.onboardingCoordinator {
                    let onboardingViewModel = OnboardingViewModel(fetchCountriesUseCase: DIContainer.shared.fetchCountriesUseCase, fetchCategoriesUseCase: DIContainer.shared.fetchCategoriesUseCase, onboardingUseCase: DIContainer.shared.onboardingUseCase, onboardingCoordinator: onboardingCoordinator)
                    OnboardingView(viewModel: onboardingViewModel)
                        .environmentObject(appCoordinator)
                } else if let headlinesCoordinator = appCoordinator.headlinesCoordinator {
                    HeadlinesView(headlinesViewModel: headlinesCoordinator.headlinesViewModel)
                }
            }
            .onAppear {
                appCoordinator.start()
            }
        }
      }
  }
