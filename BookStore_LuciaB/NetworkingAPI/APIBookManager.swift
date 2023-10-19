//
//  APIBookManager.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Alamofire
import Foundation

class BookService {
    static let shared = BookService()
    
    private let baseURL = "https://www.googleapis.com/books/v1/volumes"
    
    func fetchBooks(query: String, maxResults: Int, startIndex: Int, completion: @escaping ([Book]?, Error?) -> Void) {
        let parameters: [String: Any] = [
            "q": query,
            "maxResults": maxResults,
            "startIndex": startIndex
        ]
        
        AF.request(baseURL, method: .get, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let jsonData = try? JSONSerialization.data(withJSONObject: value),
                   let bookData = try? JSONDecoder().decode(BookData.self, from: jsonData) {
                    
                    // Parse bookData and map it to your Book model
                    let books = bookData.items?.compactMap { $0.volumeInfo.toBook() } ?? []
                    completion(books, nil)
                } else {
                    completion(nil, APIError.parsingError)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
