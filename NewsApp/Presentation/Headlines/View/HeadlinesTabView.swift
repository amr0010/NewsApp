//
//  HeadlinesTabView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI

struct HeadlinesTabView: View {
    @StateObject var viewModel: HeadlinesViewModel
    @State var presentArticleDetails = false
    
    var body: some View {
           NavigationView {
               VStack {
                   SearchBar(text: $viewModel.searchText)
                       .padding()
                   
                   List(viewModel.articles) { article in
                       ArticleRowView(article: article, onBookmarkTapped: { article in
                           viewModel.toggleBookmark(for: article)
                       })

                   }
                   .navigationTitle("Headlines")
                   .onAppear {
                       viewModel.loadHeadlines()
                   }
               }
           }
       }
}
