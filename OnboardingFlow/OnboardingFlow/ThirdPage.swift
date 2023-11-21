//
//  ThirdPage.swift
//  OnboardingFlow
//
//  Created by Lucia Barrela on 21/11/2023.
//

import SwiftUI

struct ThirdPage: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Projects")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.top, 100)
            
            FeatureCard(iconName: "person.2.crop.square.stack.fill",
                        description: "A project to help improve swift development and xcode userbility.")
            
            FeatureCard(iconName: "quote.bubble.fill", description: "Trying to define a Card that is the same lenght has the above card.")
            
            Spacer()
            
        }
        
        .padding()
    }
}
#Preview {
    ThirdPage()
}
