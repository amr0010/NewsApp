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

    init(headlinesViewModel: HeadlinesViewModel) {
        self.headlinesViewModel = headlinesViewModel
       // self.savedArticleViewModel = savedArticleViewModel
    }
}
