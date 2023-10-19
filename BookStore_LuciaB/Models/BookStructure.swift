//
//  BookStructure.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Foundation

struct Book {
    let id: String
    let title: String
    let authors: [String]
    let description: String
    let buyLink: String?
    var isFavorite: Bool
}
