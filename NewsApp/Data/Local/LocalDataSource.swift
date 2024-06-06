//
//  LocalDataSource.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

class LocalDataSource {
    private let realmManager: RealmManager

    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
}
