//
//  WelcomeView.swift
//  LuBooks
//
//  Created by Lucia Barrela on 27/10/2023.
//

import SwiftUI

struct WelcomeView: View {
    // Binding to control the transition to ContentView
    @Binding var showContentView: Bool

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Text("Welcome to LuBooks!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                Text("Your Reading Companion")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)

                JumpingBookIcon()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)

                // Start Reading button
                Button(action: {
                    // When the button is pressed, toggle the showContentView state
                    showContentView.toggle()
                }) {
                    Text("Start Reading")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(25)
                }
                .padding(.top, 20)
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showContentView: .constant(false))
    }
}
