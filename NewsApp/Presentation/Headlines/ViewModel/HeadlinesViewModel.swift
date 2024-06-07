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
    @Published var onboardingData: OnboardingEntity? {
        didSet {
            fetchHeadlines()
        }
    }

    private let fetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol
    private let onboardingUseCase: OnboardingUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(fetchHeadlinesUseCase: FetchHeadlinesUseCaseProtocol,
         onboardingUseCase: OnboardingUseCaseProtocol) {
        self.fetchHeadlinesUseCase = fetchHeadlinesUseCase
        self.onboardingUseCase = onboardingUseCase
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
}
