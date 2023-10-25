//
//  BookDetailView.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//


import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import Foundation


struct BookDetailView: View {
    var book: Book
    @ObservedObject var booksData: getData
    @State private var isFavorite: Bool

    init(book: Book, booksData: getData) {
        self.book = book
        self.booksData = booksData
        _isFavorite = State(initialValue: booksData.isFavorite(book: book))
    }

    
    
    
    var body: some View {
        ScrollView {
            // Your book detail view code here
            if let thumbnailURL = URL(string: book.imurl) {
                WebImage(url: thumbnailURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(10)
            } else {
                Text("No Image Available")
            }

            Text(book.title)
                .font(.title)

            Text("Author: \(book.authors)")
                .font(.subheadline)

            Text(book.desc)
                .font(.body)

            if let buyLink = URL(string: book.url) {
                Button(action: {
                    UIApplication.shared.open(buyLink)
                }) {
                    Text("Buy Now")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }

            Button(action: {
                booksData.toggleFavorite(book: book)
                isFavorite = book.isFavorite
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .padding()

        }
        .navigationBarTitle(book.title)
        .onAppear {
            isFavorite = book.isFavorite
        }
    }
}

