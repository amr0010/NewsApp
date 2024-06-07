//
//  SourceDTO.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct SourceDTO: Identifiable, DataModelProtocol {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
}
