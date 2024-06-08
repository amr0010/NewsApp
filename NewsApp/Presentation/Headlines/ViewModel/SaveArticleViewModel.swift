//
//  SaveArticleViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Combine
import Foundation

//class SaveArticleViewModel: ObservableObject {
//    @Published var savedArticles: [ArticleEntity] = []
//    @Published var errorMessage: String?
//    @Published var isLoading: Bool = false
//
//    private let fetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol
//    private let saveArticleUseCase: SaveArticleUseCaseProtocol
//    private var cancellables = Set<AnyCancellable>()
//
//    init(
//        fetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol,
//        saveArticleUseCase: SaveArticleUseCaseProtocol
//    ) {
//        self.fetchSavedArticlesUseCase = fetchSavedArticlesUseCase
//        self.saveArticleUseCase = saveArticleUseCase
//        loadSavedArticles()
//    }
//
//    func loadSavedArticles() {
//        isLoading = true
//        fetchSavedArticlesUseCase.execute()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isLoading = false
//                if case .failure(let error) = completion {
//                    self?.errorMessage = error.localizedDescription
//                }
//            }, receiveValue: { [weak self] articles in
//                self?.savedArticles = articles
//            })
//            .store(in: &cancellables)
//    }
//    
//    func removeSavedItem(article: ArticleEntity) {
//        
//    }
//}
