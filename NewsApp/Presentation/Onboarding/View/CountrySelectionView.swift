//
//  CountrySelectionView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

struct CountrySelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack {
            Text("Select Country")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            SearchBar(text: $viewModel.searchText)
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.filteredCountries) { country in
                        HStack {
                            Text(country.flag).padding(.horizontal)
                            Text(country.name)
                                .font(.headline)
                                .padding()
                            Spacer()
                            if viewModel.selectedCountry?.code == country.code {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        
                        .padding()
                        .onTapGesture {
                            viewModel.selectCountry(country)
                        }
                    }
                }
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .background(Color.cyan)
    }
}

