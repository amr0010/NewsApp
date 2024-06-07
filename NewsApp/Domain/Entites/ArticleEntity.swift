//
//  ArticleEntity.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct ArticleEntity: Identifiable {
    let id: UUID
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    let content: String
    let sourceName: String
}

