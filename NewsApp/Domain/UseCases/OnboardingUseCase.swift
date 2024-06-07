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
    func getOnboardingData() -> AnyPublisher<OnboardingEntity?, Error>

}

class OnboardingUseCase: OnboardingUseCaseProtocol {
    private let realmManager: RealmManagerProtocol

    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }

    func saveOnboardingData(selectedCountry: CountryEntity, selectedCategories: [CategoryEntity]) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let onboardingData = OnboardingEntity()
            onboardingData.selectedCountry = selectedCountry.code
            onboardingData.selectedCategories.append(objectsIn: selectedCategories.map { $0.name })

            do {
                try self.realmManager.add(onboardingData)
                UserDefaults.standard.set(true, forKey: Constants.Preferences.onboardingCompletedKey)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getOnboardingData() -> AnyPublisher<OnboardingEntity?, Error> {
            return Future<OnboardingEntity?, Error> { promise in
                do {
                    let data = try self.realmManager.get(OnboardingEntity.self).first
                    promise(.success(data))
                } catch {
                    promise(.failure(error))
                }
            }
            .eraseToAnyPublisher()
        }
}
