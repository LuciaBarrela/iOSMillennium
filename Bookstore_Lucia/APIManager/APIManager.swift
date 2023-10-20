//
//  APIManager.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 20/10/2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func fetchBooks(completion: @escaping ([Book]?) -> Void) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0&fields=items(id,volumeInfo(title,authors,description,imageLinks/thumbnail))"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(BookResponse.self, from: data) {
                        let books = decodedResponse.items
                        completion(books)
                    } else {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        } else {
            completion(nil)
        }
    }
}
