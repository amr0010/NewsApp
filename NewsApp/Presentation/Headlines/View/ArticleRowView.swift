//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI

struct ArticleRowView: View {
    let article: ArticleEntity
    @State private var isBookmarked: Bool = false
    
    var body: some View {
        HStack(alignment: .top) {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            } else {
                Color.gray.frame(width: 100, height: 100)
            }
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
                isBookmarked.toggle()
            }) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(isBookmarked ? .blue : .gray)
            }
        }
        .padding(.vertical, 8)
    }
}
