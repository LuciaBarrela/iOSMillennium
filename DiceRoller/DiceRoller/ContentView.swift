//
//  ContentView.swift
//  DiceRoller
//
//  Created by Lucia Barrela on 21/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var numberOfDice: Int = 1
    var body: some View {
        
       
        
        VStack {
            
            
            Text("Dice Roller")
                .font(.largeTitle.lowercaseSmallCaps())
                .foregroundStyle(.white)
            
            HStack {
                ForEach(1...numberOfDice, id: \.self) { _ in
                    DiceView()
                        .foregroundColor(.white)
                }
            }
            
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill") {
                    numberOfDice -= 1
                }
                
                .disabled(numberOfDice == 1)
                
                
                Button("Add Dice", systemImage: "plus.circle.fill") {
                    numberOfDice += 1
                    
                }
                
                .disabled(numberOfDice == 3)
            }
            
            .padding()
            .labelStyle(.iconOnly)
            .font(.title)
      
        }
    
     
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.colorBack)
        .tint(.white)
 
    }
       
}

#Preview {
    ContentView()
}
