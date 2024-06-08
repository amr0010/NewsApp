//
//  HeadlinesViewModel.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

class HeadlinesViewModel: ObservableObject {
    @Published var articles: [ArticleEntity] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var savedArticles: [ArticleEntity] = []
    @Published var onboardingData: OnboardingEntity? {
        didSet {
            fetchHeadlines()
        }
    }
    
    @Published var searchText: String = "" {
        didSet {
            searchArticles(query: searchText)
        }
    }

    private let fetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol
    private let onboardingUseCase: OnboardingUseCaseProtocol
    private let searchArticlesUseCase: SearchArticlesUseCaseProtocol
    private let saveArticleUseCase: SaveArticleUseCaseProtocol
    private let fetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol
    private let deleteSavedArticleUseCase: DeleteSavedArticleUseCase



    private var cancellables = Set<AnyCancellable>()

    init(
        fetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol,
        onboardingUseCase: OnboardingUseCaseProtocol,
        searchArticlesUseCase: SearchArticlesUseCaseProtocol,
        saveArticleUseCase: SaveArticleUseCaseProtocol,
        fetchSavedArticlesUseCase: FetchSavedArticlesUseCaseProtocol,
        deleteSavedArticleUseCase: DeleteSavedArticleUseCase
    ) {
        self.fetchHeadlinesUseCase = fetchHeadlinesUseCase
        self.onboardingUseCase = onboardingUseCase
        self.searchArticlesUseCase = searchArticlesUseCase
        self.saveArticleUseCase = saveArticleUseCase
        self.fetchSavedArticlesUseCase = fetchSavedArticlesUseCase
        self.deleteSavedArticleUseCase = deleteSavedArticleUseCase
    }
    
    private func loadOnboardingData() {
          onboardingUseCase.getOnboardingData()
              .receive(on: DispatchQueue.main)
              .sink(receiveCompletion: { completion in
                  if case .failure(let error) = completion {
                      self.errorMessage = error.localizedDescription
                  }
              }, receiveValue: { [weak self] data in
                  guard let data = data else { return }
                  self?.onboardingData = data
              })
              .store(in: &cancellables)
      }

    func loadHeadlines() {
        loadOnboardingData()
    }
    
    private func fetchHeadlines() {
        guard let onboardingData else { return }
        Publishers.Zip(fetchSavedArticlesUseCase.execute(), fetchHeadlinesUseCase.execute(onboardingEntity: onboardingData))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { (savedArticles, articles) in
                let updatedArticles = articles.compactMap({ article in
                    var article = article
                    if savedArticles.contains(where: {$0.title == article.title}) {
                        article.isBookmarked = true
                    }
                    return article
                })
                self.articles = updatedArticles
            })
            .store(in: &cancellables)
    }
    
    func loadSavedArticles() {
           isLoading = true
           fetchSavedArticlesUseCase.execute()
               .receive(on: DispatchQueue.main)
               .sink(receiveCompletion: { [weak self] completion in
                   self?.isLoading = false
                   if case .failure(let error) = completion {
                       self?.errorMessage = error.localizedDescription
                   }
               }, receiveValue: { [weak self] articles in
                   self?.savedArticles = articles
               })
               .store(in: &cancellables)
       }
    
    private func searchArticles(query: String) {
        guard !query.isEmpty else {
            loadHeadlines()
            return
        }
        
        isLoading = true
        searchArticlesUseCase.execute(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
            .store(in: &cancellables)
    }
    
    func toggleBookmark(for article: ArticleEntity) {
            if article.isBookmarked {
                removeArticle(article)
            } else {
                saveArticle(article)
            }
        }
        
        private func saveArticle(_ article: ArticleEntity) {
            var articleToSave = article
            articleToSave.isBookmarked = true
            
            saveArticleUseCase.execute(article: articleToSave)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] in
                    print("Article saved successfully")
                    if let index = self?.articles.firstIndex(where: { $0.id == articleToSave.id }) {
                        self?.articles[index].isBookmarked = true
                    }
                    self?.savedArticles.append(articleToSave)
                })
                .store(in: &cancellables)
        }
        
        private func removeArticle(_ article: ArticleEntity) {
            deleteSavedArticleUseCase.execute(article: article)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] completion in
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] in
                    print("Article removed successfully")
                    if let index = self?.articles.firstIndex(where: { $0.id == article.id }) {
                        self?.articles[index].isBookmarked = false
                    }
                    self?.savedArticles.removeAll(where: { $0.id == article.id })
                })
                .store(in: &cancellables)
        }
}
