//
//  CategoryMapper.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

struct CategoryMapper: MapperProtocol {
   
    typealias DataModel = SourcesResponseDTO
    typealias Entity = CategoryEntity

    func mapToEntity(from model: SourcesResponseDTO) -> [CategoryEntity] {
        return model.sources?.compactMap { source in
                    guard let category = source.category, let id = source.id else { return nil }
                    return CategoryEntity(name: category, id: id)
                } ?? []
    }

    func mapToDataModel(from entity: CategoryEntity) -> SourcesResponseDTO {
        //example of mapping back if needed, not needed in this task
        return SourcesResponseDTO(status: nil, sources: [])
    }
}
