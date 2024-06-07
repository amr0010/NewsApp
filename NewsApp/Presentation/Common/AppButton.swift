//
//  AppButton.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import SwiftUI

struct AppButton: View {
    let title: String
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isEnabled ? Color.blue : Color.gray)
                .cornerRadius(10)
                .opacity(isEnabled ? 1 : 0.5)
        }
        .disabled(!isEnabled)
    }
}
