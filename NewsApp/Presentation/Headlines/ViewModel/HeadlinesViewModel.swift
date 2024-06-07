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


    private var cancellables = Set<AnyCancellable>()

    init(fetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol,
         onboardingUseCase: OnboardingUseCaseProtocol, searchArticlesUseCase: SearchArticlesUseCaseProtocol) {
        self.fetchHeadlinesUseCase = fetchHeadlinesUseCase
        self.onboardingUseCase = onboardingUseCase
        self.searchArticlesUseCase = searchArticlesUseCase
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
        fetchHeadlinesUseCase.execute(onboardingEntity: onboardingData)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { articles in
                self.articles = articles
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
}
