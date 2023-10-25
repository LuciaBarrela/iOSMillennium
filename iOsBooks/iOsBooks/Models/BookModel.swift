//
//  BookModel.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//


import Foundation
import SwiftyJSON
import SDWebImage
import SDWebImageSwiftUI
import CoreData

class Book : Identifiable, ObservableObject {
    var id : String
    var title : String
    var authors : String
    var desc : String
    var imurl : String
    var url : String
    @Published var isFavorite: Bool = false

    init(id: String, title: String, authors: String, desc: String, imurl: String, url: String) {
        self.id = id
        self.title = title
        self.authors = authors
        self.desc = desc
        self.imurl = imurl
        self.url = url
    }
}

class getData : ObservableObject {
    @Published var data = [Book]()
    
    // Function to save favorite book IDs
    func saveFavoriteBookIDs(bookIDs: [String]) {
        UserDefaults.standard.set(bookIDs, forKey: "favoriteBookIDs")
    }
    
    // Function to load favorite book IDs
    func loadFavoriteBookIDs() -> [String] {
        if let bookIDs = UserDefaults.standard.stringArray(forKey: "favoriteBookIDs") {
            return bookIDs
        }
        return []
    }
    
    // Function to check if a book is a favorite
    func isFavorite(book: Book) -> Bool {
        return loadFavoriteBookIDs().contains(book.id)
    }
    
    // Function to toggle the favorite status of a book
    func toggleFavorite(book: Book) {
        var favoriteBookIDs = loadFavoriteBookIDs()
        if isFavorite(book: book) {
            if let index = favoriteBookIDs.firstIndex(of: book.id) {
                favoriteBookIDs.remove(at: index)
            }
        } else {
            favoriteBookIDs.append(book.id)
        }
        saveFavoriteBookIDs(bookIDs: favoriteBookIDs)
        
        // Update the isFavorite property of the book
        book.isFavorite = isFavorite(book: book)
    }
    // ...
    
    
    
    
    init() {
        let url = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            let items = json["items"].array!
            
            for item in items {
                let id = item["id"].stringValue
                let title = item["volumeInfo"]["title"].stringValue
                
                let authorsJSON = item["volumeInfo"]["authors"]
                let authorsArray = authorsJSON.arrayValue
                var author = ""
                
                for authorJSON in authorsArray {
                    author += authorJSON.stringValue
                }
                
                let description = item["volumeInfo"]["description"].stringValue
                let imurl = item["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                let url1 = item["volumeInfo"]["previewLink"].stringValue
                
                DispatchQueue.main.async {
                    self.data.append(Book(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1))
                }
            }
        }.resume()
        
        // After fetching data, update the isFavorite property for each book
        for book in self.data {
            book.isFavorite = isFavorite(book: book)
        }
    }
}
