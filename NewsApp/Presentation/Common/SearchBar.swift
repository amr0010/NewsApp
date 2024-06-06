//
//  SearchBar.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}

