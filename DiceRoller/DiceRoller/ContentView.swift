//
//  ContentView.swift
//  DiceRoller
//
//  Created by Lucia Barrela on 21/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Text("Dice Roller")
                .font(.largeTitle.lowercaseSmallCaps())
            
            HStack {
                ForEach(1...3, id: \.self) { _ in
                    DiceView()
                }
            }
            
        }
        
        .padding()
    }
}

#Preview {
    ContentView()
}
