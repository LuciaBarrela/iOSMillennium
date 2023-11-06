//
//  LoginView.swift
//  ToDoList
//
//  Created by Lucia Barrela on 03/11/2023.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                //Header
                HeaderView()
                
                //Login Form
                
                Form{
                    TextField("Email Address", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    Button {
                        //Attempt log in
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                            
                            Text("Log in")
                                .foregroundColor(Color.white)
                                .bold()
                            
                        }
                    }
                    .padding()
                    
                }
                
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
