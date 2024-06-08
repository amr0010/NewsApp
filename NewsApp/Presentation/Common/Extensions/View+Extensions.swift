//
//  View+Extensions.swift
//  NewsApp
//
//  Created by Amr Magdy on 08/06/2024.
//

import SwiftUI

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
