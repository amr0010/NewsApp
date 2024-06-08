//
//  CountrySelectionView.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import SwiftUI

struct CountrySelectionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    let columns = [
        GridItem(.flexible(minimum: 150, maximum: 200)),
        GridItem(.flexible(minimum: 150, maximum: 200))
    ]
    
    var body: some View {
        VStack {
            Text("Select Country")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            SearchBar(text: $viewModel.searchText)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredCountries) { country in
                        BoxView(
                            title: country.flag,
                            subtitle: country.code,
                            isSelected: viewModel.selectedCountry?.code == country.code
                        ) {
                            viewModel.selectCountry(country)
                        }
                    }
                }
                .padding()
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            viewModel.loadCountries()
        }
        .background(Color(.white))
    }
}
