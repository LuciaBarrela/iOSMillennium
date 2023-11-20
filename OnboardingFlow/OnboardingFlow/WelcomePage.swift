//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by Lucia Barrela on 20/11/2023.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(Color.mint)
                .frame(width: 150, height: 150)
                
                Image(systemName: "person.fill.checkmark")
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
                
            }
            
            Text("Welcome to MyApp")
                .font(.title)
            .fontWeight(.semibold)
            .padding(.top)
            
            
            Text("This is a learning experience")
                .font(.title2)
                
        }
        
        .padding()
        
    }
}

#Preview {
    WelcomePage()
}
