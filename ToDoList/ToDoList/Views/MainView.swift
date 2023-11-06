//
//  ContentView.swift
//  ToDoList
//
//  Created by Lucia Barrela on 03/11/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewViewModel() 
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            
            //signed in
            ToDoListView()
            
        } else {
            LoginView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
