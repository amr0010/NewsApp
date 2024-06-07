//
//  ArticleMapper.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

class ArticleMapper {
    func mapToEntity(from models: [ArticleDTO]) -> [ArticleEntity] {
        return models.map { model in
            ArticleEntity(
                id: model.id,
                title: model.title ?? "",
                description: model.description,
                url: model.url ?? "",
                urlToImage: model.urlToImage,
                publishedAt: Date(),
                content: model.content ?? "",
                sourceName: ""
            )
        }
    }
}
