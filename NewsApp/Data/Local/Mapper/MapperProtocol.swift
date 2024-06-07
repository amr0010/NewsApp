//
//  MapperProtocol.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation

protocol MapperProtocol {
    associatedtype DataModel: DataModelProtocol
    associatedtype Entity: EntityProtocol

    func mapToEntity(from model: DataModel) -> [Entity]
    func mapToDataModel(from entity: Entity) -> DataModel
}
