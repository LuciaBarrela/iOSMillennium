//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Lucia Barrela on 21/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var names: [String] = ["Miguel", "Susana", "Joana", "Po-Chung"]
    @State private var nameToAdd = ""
    
    var body: some View {
        
            VStack {
                List {
                    ForEach(names, id: \.self) { name in
                        Text(name)
                    }
                }
                
                TextField("Add Name", text: $nameToAdd)
                    .onSubmit {
                        if !nameToAdd.isEmpty {
                            names.append(nameToAdd)
                            nameToAdd = ""
                        }
                    }
            }
            .padding()
        }
    }

#Preview {
    ContentView()
}
