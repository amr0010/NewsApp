//
//  OnboardingView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//
import SwiftUI

struct OnboardingView: View {
    @ObservedObject var coordinator: OnboardingCoordinator
    @State private var showCategorySelection = false

    var body: some View {
        VStack {
            if showCategorySelection {
                CategorySelectionView(
                    viewModel: coordinator.categorySelectionViewModel,
                    onBack: {
                        withAnimation {
                            showCategorySelection = false
                        }
                    }
                )
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
                Button(action: {
                    coordinator.finishOnboarding()
                }) {
                    Text("Finish Onboarding")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .transition(.move(edge: .top))
                .animation(.easeInOut)
            } else {
                CountrySelectionView(viewModel: coordinator.countrySelectionViewModel)
                Button(action: {
                    withAnimation {
                        showCategorySelection = true
                    }
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .background(Color.cyan)
    }
}
