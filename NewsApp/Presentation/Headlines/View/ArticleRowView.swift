//
//  ArticleRowView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI
import Kingfisher

struct ArticleRowView: View {
    var article: ArticleEntity
    @State var isBookmarked: Bool = false
    var onBookmarkTapped: (ArticleEntity) -> Void

    var body: some View {
        HStack(alignment: .top) {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .onTapGesture {
                        if let url = URL(string: article.url) {
                            UIApplication.shared.open(url)
                        }
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
            .onTapGesture {
                if let url = URL(string: article.url) {
                    UIApplication.shared.open(url)
                }
            }
            Spacer()
            Button(action: {
                onBookmarkTapped(article)
            }) {
                Image(systemName: article.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(article.isBookmarked ? .blue : .gray)
            }
        }
        .padding(.vertical, 8)
    }
}
