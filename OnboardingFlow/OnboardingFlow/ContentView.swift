//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by Lucia Barrela on 20/11/2023.
//

import SwiftUI

let gradientColors: [Color] = [
    .gradientTop,
    .gradientBottom
]

struct ContentView: View {
    var body: some View {
        TabView {
            
            WelcomePage()
            FeaturesPage()
        }
        
        .background(Gradient(colors: gradientColors))
        //lets you swipe the .page tag
        .tabViewStyle(.page)
        
    }
}

#Preview {
    ContentView()
}
