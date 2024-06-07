//
//  HeadlinesView.swift
//  NewsApp
//
//  Created by Amr Magdy on 07/06/2024.
//

import SwiftUI

struct HeadlinesView: View {
    @StateObject var headlinesViewModel: HeadlinesViewModel

    var body: some View {
        TabView {
            HeadlinesTabView(viewModel: headlinesViewModel)
                .tabItem {
                    Label("All Articles", systemImage: "list.bullet")
                }
            Text("")
                .tabItem {
                    Label("Saved Articles", systemImage: "bookmark")
                }
        }
    }
}
