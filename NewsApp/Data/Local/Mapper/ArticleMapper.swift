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
            let publishedDate = Date.from(model.publishedAt ?? "") ?? Date()

            return ArticleEntity(
                id: model.id,
                title: model.title ?? "",
                description: model.description,
                url: model.url ?? "",
                urlToImage: model.urlToImage,
                publishedAt: publishedDate,
                content: model.content ?? "",
                sourceName: ""
            )
        }
    }
}
