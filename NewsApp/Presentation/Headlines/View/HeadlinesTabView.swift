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
                   CategoryButtonsView(viewModel: viewModel)
                   List(viewModel.articles) { article in
                       ArticleRowView(article: article, onBookmarkTapped: { article in
                           viewModel.toggleBookmark(for: article)
                       })
                       
                   }
                   .navigationTitle("Headlines")
                   .onViewDidLoad {
                       viewModel.loadHeadlines()
                   }
               }
           }
    }
}


struct CategoryButtonsView: View {
    @ObservedObject var viewModel: HeadlinesViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.categories, id: \.self) { category in
                    Button(action: {
//                        viewModel.selectCategory(category)
                    }) {
                        Text(category)
                            .padding()
                            .background(viewModel.selectedCategory == category ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}





