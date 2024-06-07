//
//  RealmManager.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation
import RealmSwift

class RealmManager: RealmManagerProtocol {
    private var realm: Realm

    init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }

    func add<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error as NSError {
            debugPrint("Failed to add object: \(error.localizedDescription)")
        }
    }

    func get<T: Object>(_ type: T.Type, filter: NSPredicate? = nil) -> Results<T>? {
        if let filter = filter {
            return realm.objects(type).filter(filter)
        }
        return realm.objects(type)
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch let error as NSError {
            debugPrint("Failed to delete object: \(error.localizedDescription)")
        }
    }

    func update(_ block: @escaping (Realm) -> Void) {
        do {
            try realm.write {
                block(realm)
            }
        } catch let error as NSError {
            debugPrint("Failed to update object: \(error.localizedDescription)")
        }
    }
}
