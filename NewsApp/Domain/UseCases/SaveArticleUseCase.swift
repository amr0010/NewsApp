//
//  SaveArticleUseCaseProtocol.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Combine

protocol SaveArticleUseCaseProtocol {
    func execute(article: ArticleEntity) -> AnyPublisher<Void, Error>
}

class SaveArticleUseCase: SaveArticleUseCaseProtocol {
    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func execute(article: ArticleEntity) -> AnyPublisher<Void, Error> {
        let realmArticleEntity = RealmArticleEntity(article: article)
        return Future<Void, Error> { promise in
            do {
                try self.realmManager.add(realmArticleEntity)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
