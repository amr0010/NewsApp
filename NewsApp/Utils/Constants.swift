//
//  Constants.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "0e8c2093da054e078a183d7d5aaa0a77"
        static let newsAPIHost = "newsapi.org"
        static let sourcesPath = "/v2/top-headlines/sources"
        static let articlesPath = "/v2/top-headlines"
        static let everythingPath = "/v2/everything"
    }
    
    struct Preferences {
        static let onboardingCompletedKey = "hasCompletedOnboarding"
    }
}
