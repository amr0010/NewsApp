//
//  OnboardingEntity.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import RealmSwift
import Foundation

class OnboardingEntity: Object, EntityProtocol {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var selectedCountry: String = ""
    let selectedCategories = List<String>()
}
