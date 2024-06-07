//
//  CountryEntity.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct CountryEntity: Identifiable {
    let id = UUID()
    let code: String
    let name: String
    let flag: String
}
