//
//  LoginView.swift
//  ToDoList
//
//  Created by Lucia Barrela on 03/11/2023.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                
                //Header
                HeaderView(title: "To Do List", subtitle: "Get things done", angle: 15, background: .pink)
                
                //Login Form
                
                Form{
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButton(
                        title: "Log in",
                        background: .blue) {
                        
                    }
                        .padding()
                }
                
                .offset(y: -50)
                
                //Create Account
                
                VStack{
                    Text("New around here?")
                    
               NavigationLink("Create an Account",
                              destination: RegisterView())
                }
                
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider{
    static var previews: some View {
        LoginView()
    }
}
