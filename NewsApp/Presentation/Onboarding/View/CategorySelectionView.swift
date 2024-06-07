//
//  CategorySelectionView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: CategorySelectionViewModel
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
            List(viewModel.categories, id: \.self) { category in
                HStack {
                    Text(category.capitalized)
                    Spacer()
                    if viewModel.selectedCategories.contains(category) {
                        Image(systemName: "checkmark")
                    }
                }
                .onTapGesture {
                    viewModel.selectCategory(category)
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            
        }
    }
}
