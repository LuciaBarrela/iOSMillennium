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
        VStack {
            Text("Welcome to LuBooks!")
                .font(.largeTitle)
                .padding()

            Text("Your Reading Companion")
                .font(.title)

            JumpingBookIcon()
                .frame(width: 50, height: 50)
                .padding(.top, 20)

            // Start Reading button
            // Start Reading button
            Button(action: {
                // When the button is pressed, toggle the showContentView state
                showContentView.toggle()
            }) {
                Text("Start Reading")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showContentView: .constant(false))
    }
}
