//
//  Constants.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "a9ba19f10ee74dbd92e5c9248fd60b59"
        static let newsAPIHost = "newsapi.org"
        static let sourcesPath = "/v2/top-headlines/sources"
        static let articlesPath = "/v2/top-headlines"
        static let everythingPath = "/v2/everything"
    }
    
    struct Preferences {
        static let onboardingCompletedKey = "hasCompletedOnboarding"
    }
}
