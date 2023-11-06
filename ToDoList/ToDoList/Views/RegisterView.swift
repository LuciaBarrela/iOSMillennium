//
//  RegisterView.swift
//  ToDoList
//
//  Created by Lucia Barrela on 03/11/2023.
//

import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()

    
    var body: some View {
        VStack{
            //Header
            HeaderView(title: "Register", subtitle: "Organize your life!", angle: -15, background: .orange)
            
            
            Form{
                
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TLButton(
                    title: "Create Account",
                    background: .green
                ) {
                    viewModel.register()
                }
                    .padding()
            }
            
            .offset(y: -50)
            Spacer()
            
            }
        }
}

#Preview {
    RegisterView()
}
