//
//  ArticlesResponseDTO.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct ArticlesResponseDTO: DataModelProtocol {
    let status: String?
    let totalResults: Int?
    let articles: [ArticleDTO]?
}
