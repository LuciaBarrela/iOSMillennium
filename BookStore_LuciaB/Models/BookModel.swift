//
//  BookModel.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Foundation

struct BookData: Codable {
    let items: [BookItem]?
}

struct BookItem: Codable {
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let buyLink: String?

    func toBook() -> Book {
        return Book(
            id: UUID().uuidString, // You can generate a unique ID for each book
            title: title,
            authors: authors ?? [],
            description: description ?? "",
            buyLink: buyLink,
            isFavorite: false
        )
    }
}

