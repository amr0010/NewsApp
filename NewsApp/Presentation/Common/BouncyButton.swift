//
//  BouncyButton.swift
//  NewsApp
//
//  Created by Amr Magdy on 06/06/2024.
//

import SwiftUI

struct BouncyButton: View {
    @State var test = false
       
       var body: some View {
           VStack {
               Image(systemName: "arrow.up.circle.fill")
                   .resizable()
                   .frame(width: 50, height: 50)

               .offset(y: test ? 0 : -80)
               .animation(.interpolatingSpring(stiffness: 350, damping: 5, initialVelocity: 10))
               
               Button(action: {self.test.toggle()}) {
                   Text("Animate")
               }
           }
       }
}

