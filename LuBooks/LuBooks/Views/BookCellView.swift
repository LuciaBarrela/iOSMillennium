//
//  BookCellView.swift
//  LuBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct BookCellView: View {
    @ObservedObject var book: Book

    var body: some View {
        VStack(spacing: 10) {
            if let thumbnailURL = URL(string: book.imurl) {
                WebImage(url: thumbnailURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 120)
                    .cornerRadius(10)
            } else {
                Image(systemName: "book.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 120)
            }

            Text(book.title)
                .font(.headline)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)

            Text(authorsText(authors: book.authors))
                .font(.subheadline)
                .foregroundColor(.gray)
                .lineLimit(1)
                .padding(.horizontal, 10)
        }
        .padding(.top, 10) // Add space at the top
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
    
    private func authorsText(authors: String) -> String {
        let authorList = authors.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
        if authorList.count > 1 {
            return "\(authorList[0]) (...)"
        }
        return authorList[0]
    }
}
