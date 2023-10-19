//
//  Book.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Foundation

struct BookResponse: Codable {
    let items: [Book]
}

struct Book: Codable, Identifiable {
    let id = UUID()
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let thumbnail: String
}
