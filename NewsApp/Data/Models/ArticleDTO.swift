//
//  ArticleDTO.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct ArticleDTO: Codable, Identifiable {
    let id: UUID = UUID()
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
//    let publishedAt: Date
//    let source: SourceDTO?
}
