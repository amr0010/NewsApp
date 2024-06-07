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
        List(viewModel.articles) { article in
            ArticleRowView(article: article)
                .onTapGesture {
                    presentArticleDetails.toggle()
                }
                .sheet(isPresented: $presentArticleDetails) { ArticleDetailView(article: article)
                }
        }
        .navigationTitle("Headlines")
       
        .onAppear {
            viewModel.loadHeadlines()
        }
    }
}
