//
//  Constants.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "51f87dd5c9a84694923fbba55d76f87c"
        static let newsAPIHost = "newsapi.org"
        static let sourcesPath = "/v2/top-headlines/sources"
        static let articlesPath = "/v2/top-headlines"
    }
    
    struct Preferences {
        static let onboardingCompletedKey = "hasCompletedOnboarding"
    }
}
