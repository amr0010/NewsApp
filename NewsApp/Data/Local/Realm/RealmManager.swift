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
                if let primaryKey = T.primaryKey() {
                    if realm.object(ofType: T.self, forPrimaryKey: object.value(forKey: primaryKey)!) != nil {
                        realm.add(object, update: .modified)
                    } else {
                        realm.add(object)
                    }
                } else {
                    realm.add(object)
                }
            }
        } catch let error as NSError {
            debugPrint("Failed to add or update object: \(error.localizedDescription)")
        }
    }
    
    func get<T: Object>(_ type: T.Type) throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(type)
    }
    
    func getAll<T: Object>(_ type: T.Type) throws -> [T] {
        let realm = try Realm()
        return Array(realm.objects(type))
    }
    
    func delete<T: Object>(_ object: T) throws {
           do {
               try realm.write {
                   if let primaryKey = T.primaryKey(), let existingObject = realm.object(ofType: T.self, forPrimaryKey: object.value(forKey: primaryKey)!) {
                       realm.delete(existingObject)
                   } else {
                       realm.delete(object)
                   }
               }
           } catch let error as NSError {
               debugPrint("Failed to delete object: \(error.localizedDescription)")
               throw error
           }
       }
}
