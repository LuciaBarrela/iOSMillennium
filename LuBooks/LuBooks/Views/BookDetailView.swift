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

            Text("Author(s): \(book.authors)")
                .font(.subheadline)

            Button(action: {
                booksData.toggleFavorite(book: book)
                isFavorite = book.isFavorite
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title)
                    .foregroundColor(isFavorite ? .red : .gray)
            }
            .padding(.top, 10) // Add spacing between authors and heart icon

            Text(book.desc)
                .font(.body)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))

            Spacer()

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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle(book.title)
        .onAppear {
            isFavorite = book.isFavorite
        }
    }
}
