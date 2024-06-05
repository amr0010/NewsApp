//
//  KeyChainManager.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//

import Foundation
import Security

public protocol KeychainManagerProtocol {
    func set(_ value: String, forKey key: String)
    func get(forKey key: String) -> String?
    func delete(forKey key: String)
}
