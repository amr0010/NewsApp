//
//  HeadlinesView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI

struct HeadlinesView: View {
    @StateObject var headlinesViewModel: HeadlinesViewModel
    @StateObject var savedArticleViewModel: SaveArticleViewModel
    var body: some View {
        TabView {
            HeadlinesTabView(viewModel: headlinesViewModel)
                .tabItem {
                    Label("All Articles", systemImage: "list.bullet")
                }
            SaveArticleTabView(viewModel: savedArticleViewModel)
                .tabItem {
                    Label("Saved Articles", systemImage: "bookmark")
                }
        }
    }
}
