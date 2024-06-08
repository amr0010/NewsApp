//
//  SaveArticleTabView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import SwiftUI

struct SaveArticleTabView: View {
    @StateObject var viewModel: HeadlinesViewModel
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    List(viewModel.savedArticles) { article in
                        ArticleRowView(article: article, onBookmarkTapped: { article in
                            viewModel.toggleBookmark(for: article)
                        })

                    }
                    .navigationTitle("Saved Articles")
                }
            }
            .onAppear {
                viewModel.loadSavedArticles()
            }
            .alert(isPresented: Binding<Bool>(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")))
            }
        }
    }
}
