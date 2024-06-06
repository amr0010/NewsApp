//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject private var appCoordinator = AppCoordinator(diContainer: DIContainer.shared)

    var body: some Scene {
        WindowGroup {
            Group {
                if let onboardingCoordinator = appCoordinator.onboardingCoordinator {
                    OnboardingView(coordinator: onboardingCoordinator)
                        .environmentObject(appCoordinator)
                } else if let headlinesCoordinator = appCoordinator.headlinesCoordinator {
                        ContentView()
                        .environmentObject(appCoordinator)
                }
            }
            .onAppear {
                appCoordinator.start()
            }
          }
      }
  }
