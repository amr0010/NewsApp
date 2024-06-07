//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: ArticleEntity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text(article.title)
                    .font(.largeTitle)
                    .bold()
                Text("Published at \(article.publishedAt, formatter: DateFormatter.articleDateFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(article.description ?? "")
                    .font(.body)
                    Text(article.content)
                        .font(.body)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(article.sourceName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DateFormatter {
    static let articleDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
