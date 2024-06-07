//
//  CategorySelectionView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var onBack: () -> Void
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    onBack()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
                .padding()
                Spacer()
            }
            Text("Select Categories")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            List(viewModel.categories, id: \.id) { category in
                HStack {
                    Text(category.name.capitalized)
                    Spacer()
                    if viewModel.selectedCategories.contains(where: { $0.id == category.id }) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    viewModel.selectCategory(category)
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.loadCategories()
        }
    }
}
