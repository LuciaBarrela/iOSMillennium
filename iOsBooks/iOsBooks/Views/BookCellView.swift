//
//  BookCellView.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//


import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct BookCellView: View {
    @ObservedObject var book: Book

    var body: some View {
        HStack {
            if !book.imurl.isEmpty {
                WebImage(url: URL(string: book.imurl))
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

            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(book.authors)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
