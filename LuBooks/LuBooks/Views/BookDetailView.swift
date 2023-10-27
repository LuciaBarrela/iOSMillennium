//
//  BookDetailView.swift
//  LuBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import Foundation
import CoreData
import SafariServices

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
            VStack {
                if let thumbnailURL = URL(string: book.imurl) {
                    WebImage(url: thumbnailURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                } else {
                    Text("No Image Available")
                }

                Text(book.title)
                    .font(.title)
                    .padding(.top, 10)

                Text("Author: \(book.authors)")
                    .font(.subheadline)

                Text(book.desc)
                    .font(.body)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))

                Spacer()

                HStack {
                    Button(action: {
                        booksData.toggleFavorite(book: book)
                        isFavorite = book.isFavorite
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(isFavorite ? .red : .gray)
                    }
                    .padding(.trailing, 20)
                    
                    // Button Safari Buy
                    
                    Button(action: {
                        if let buyLink = URL(string: book.url) {
                            // Create a Safari view controller to display the web page
                            let safariViewController = SFSafariViewController(url: buyLink)
                            
                            // Present the Safari view controller
                            UIApplication.shared.windows.first?.rootViewController?.present(safariViewController, animated: true, completion: nil)
                        }
                    }) {
                        Text("Buy Now")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    }
                }
            }
            .navigationBarTitle(book.title)
            .onAppear {
                isFavorite = book.isFavorite
            }
        }
    }
