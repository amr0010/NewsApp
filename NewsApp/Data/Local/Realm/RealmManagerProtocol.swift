//
//  RealmManagerProtocol.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import Foundation
import RealmSwift

protocol RealmManagerProtocol {
    func add<T: Object>(_ object: T)
    func get<T: Object>(_ type: T.Type) throws -> Results<T>
}
