//
//  Constants.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "c7ba323e82ca4c3e949874cb5c4d3d03"
        static let newsAPIHost = "newsapi.org"
        static let sourcesPath = "/v2/top-headlines/sources"
        static let articlesPath = "/v2/top-headlines"
        static let everythingPath = "/v2/everything"
    }
    
    struct Preferences {
        static let onboardingCompletedKey = "hasCompletedOnboarding"
    }
}
