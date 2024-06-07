//
//  OnboardingUseCase.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import Combine

protocol OnboardingUseCaseProtocol {
    func saveOnboardingData(selectedCountry: CountryEntity, selectedCategories: [CategoryEntity]) -> AnyPublisher<Void, Error>
}

class OnboardingUseCase: OnboardingUseCaseProtocol {
    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func saveOnboardingData(selectedCountry: CountryEntity, selectedCategories: [CategoryEntity]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let onboardingData = OnboardingData()
            onboardingData.selectedCountry = selectedCountry.name
            onboardingData.selectedCategories.append(objectsIn: selectedCategories.map { $0.name })

            do {
                try self.realmManager.add(onboardingData)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
