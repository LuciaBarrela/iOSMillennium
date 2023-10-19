//
//  BookDetailView.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    var body: some View {
        VStack {
            Text(book.volumeInfo.title)
                .font(.title)
                .fontWeight(.bold)

            if let authors = book.volumeInfo.authors {
                Text("Author(s): " + authors.joined(separator: ", "))
                    .foregroundColor(.gray)
            }

            if let description = book.volumeInfo.description {
                Text(description)
                    .padding(.top, 10)
            }

            Spacer()
        }
        .padding()
        .navigationBarTitle("Book Detail")
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBook = Book(
            volumeInfo: VolumeInfo(
                title: "Sample Book",
                authors: ["Author 1", "Author 2"],
                description: "This is a sample book description.",
                imageLinks: ImageLinks(thumbnail: "https://example.com/thumbnail.jpg")
            )
        )
        }
    }

