//
//  HeadlinesCoordinator.swift
//  NewsApp
//
//  Created by Amr Magdy on 05/06/2024.
//
import SwiftUI
import Combine

class HeadlinesCoordinator: ObservableObject {
    @Published var headlinesViewModel: HeadlinesViewModel
    @Published var savedArticleViewModel: SaveArticleViewModel

    init(headlinesViewModel: HeadlinesViewModel, savedArticleViewModel: SaveArticleViewModel) {
        self.headlinesViewModel = headlinesViewModel
        self.savedArticleViewModel = savedArticleViewModel
    }
}
