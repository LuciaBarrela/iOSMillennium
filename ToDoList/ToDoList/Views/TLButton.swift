//
//  TLButton.swift
//  ToDoList
//
//  Created by Lucia Barrela on 06/11/2023.
//

import SwiftUI

struct TLButton: View {
    
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
                
            }
        }
        
    }
    
}

#Preview {
    TLButton(title: "Value", background: .pink) {
        
        //Action
        
        
    }
}
