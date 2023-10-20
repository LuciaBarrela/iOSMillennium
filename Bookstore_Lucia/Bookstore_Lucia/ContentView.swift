//
//  ContentView.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var books: [Book] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible())], spacing: 20) {
                    ForEach(books, id: \.id) { book in
                        NavigationLink(destination: BookDetailView(book: book)) {
                            BookRow(book: book)
                        }
                    }
                }
                .padding()
            }
            .onAppear(perform: fetchData)
            .navigationBarTitle("Lucia's Bookstore")
        }
    }
    
    //fetching the API information
    func fetchData() {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0&fields=items(id,volumeInfo(title,authors,description,imageLinks/thumbnail))"

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(BookResponse.self, from: data) {
                        DispatchQueue.main.async {
                            self.books = decodedResponse.items
                        }
                    }
                }
            }.resume()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
