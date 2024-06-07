//
//  SourcesResponse.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct SourcesResponseDTO: DataModelProtocol {
    let status: String?
    let sources: [SourceDTO]?
}
