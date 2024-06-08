//
//  OnboardingView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    @State private var showCategorySelection = false

    var body: some View {
        VStack {
            if showCategorySelection {
                CategorySelectionView(
                    viewModel: viewModel,
                    onBack: {
                        withAnimation {
                            showCategorySelection = false
                        }
                    }
                )
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
                AppButton(title: "Finish", isEnabled: viewModel.canFinishOnboarding) {
                    viewModel.finishOnboarding()
                          }
                .padding()
                .transition(.move(edge: .top))
                .animation(.easeInOut)
            } else {
                CountrySelectionView(viewModel: viewModel)
                AppButton(title: "Next", isEnabled: viewModel.canProceedToCategories) {
                              withAnimation {
                                  showCategorySelection = true
                              }
                          }
                .padding()
            }
        }
        .padding()
        .background(Color.cyan)
    }
}
