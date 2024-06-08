//
//  BoxView.swift
//  NewsApp
//
//  Created by Amr Magdy on 08/06/2024.
//

import SwiftUI

struct BoxView: View {
    var title: String
    var subtitle: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
            Text(subtitle)
                .font(.headline)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(isSelected ? Color.blue.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onTapGesture {
            onTap()
        }
    }
}
