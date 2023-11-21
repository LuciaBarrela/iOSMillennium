//
//  DiceView.swift
//  DiceRoller
//
//  Created by Lucia Barrela on 21/11/2023.
//

import SwiftUI

struct DiceView: View {
    
   @State private var numberOfPips: Int = 1
    
    var body: some View {
        
        VStack {
            Image(systemName: "die.face.\(numberOfPips)")
                .resizable()
            .frame(width: 120, height: 120)
       
        
        Button("Roll") {
            
            withAnimation {
                
                numberOfPips = Int.random(in: 1...6)
                
            }
            
            }
            
        .buttonStyle(.bordered)
            
        }
    }
}

#Preview {
    DiceView()
}
