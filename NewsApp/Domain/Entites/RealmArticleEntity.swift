//
//  RealmArticleEntity.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import RealmSwift

class RealmArticleEntity: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var descriptionText: String? = nil
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String? = nil
    @objc dynamic var publishedAt: Date = Date()
    @objc dynamic var content: String = ""
    @objc dynamic var sourceName: String = ""
    @objc dynamic var isBookmarked: Bool = false

    override static func primaryKey() -> String? {
        return "title"
    }

    convenience init(article: ArticleEntity) {
        self.init()
        self.id = article.id.uuidString
        self.title = article.title
        self.descriptionText = article.description
        self.url = article.url
        self.urlToImage = article.urlToImage
        self.publishedAt = article.publishedAt
        self.content = article.content
        self.sourceName = article.sourceName
        self.isBookmarked = article.isBookmarked
    }

    var articleEntity: ArticleEntity {
        return ArticleEntity(
            id: UUID(uuidString: self.id) ?? UUID(),
            title: self.title,
            description: self.descriptionText,
            url: self.url,
            urlToImage: self.urlToImage,
            publishedAt: self.publishedAt,
            content: self.content,
            sourceName: self.sourceName,
            isBookmarked: self.isBookmarked
        )
    }
}
