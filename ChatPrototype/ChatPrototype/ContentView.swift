//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Lucia Barrela on 17/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 25){
            Text("Knock, knock!")
            
                .padding()
                .background(Color.mint, in: RoundedRectangle(cornerRadius: 8))
                
            Text("Who's there?")
                .padding()
                .background(Color.yellow, in: RoundedRectangle(cornerRadius: 8))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
