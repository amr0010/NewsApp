//
//  DeleteSavedArticleUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 08/06/2024.
//

import Foundation
import Combine

protocol DeleteSavedArticleUseCaseProtocol {
    func execute(article: ArticleEntity) -> AnyPublisher<Void, Error>
}

class DeleteSavedArticleUseCase: DeleteSavedArticleUseCaseProtocol {
    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func execute(article: ArticleEntity) -> AnyPublisher<Void, Error> {
        let realmArticleEntity = RealmArticleEntity(article: article)
        return Future<Void, Error> { promise in
            do {
                try self.realmManager.delete(realmArticleEntity)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
