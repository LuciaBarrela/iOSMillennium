//
//  BookModel.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.



import Foundation
import SwiftyJSON
import SDWebImage
import SDWebImageSwiftUI
import CoreData

class Book: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var authors: String
    @NSManaged var desc: String
    @NSManaged var imurl: String
    @NSManaged var url: String
    @NSManaged var isFavorite: Bool

    // Add @NSManaged properties for the Core Data attributes
    @NSManaged var coreDataAttribute1: String
    @NSManaged var coreDataAttribute2: Int16

    // ... Add @NSManaged properties for all attributes in the Core Data entity
}

class getData: ObservableObject {
    @Published var data: [Book] = []
    
    private let context = PersistenceController.shared.container.viewContext
    
    init() {
        do {
            let fetchRequest: NSFetchRequest<BooksEntity> = NSFetchRequest<BooksEntity>(entityName: "BooksEntity")
            fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
            
            let booksEntities = try context.fetch(fetchRequest)
            
            self.data = booksEntities.map { booksEntity in
                let book = Book(context: context)
                
                // Set Core Data attributes
                book.coreDataAttribute1 = "" // Replace with actual values
                book.coreDataAttribute2 = 0  // Replace with actual values
                
                if let id = booksEntity.id {
                    book.id = id
                }
                
                if let title = booksEntity.title {
                    book.title = title
                }
                
                if let authors = booksEntity.authors {
                    book.authors = authors
                }
                
                if let desc = booksEntity.desc {
                    book.desc = desc
                }
                
                if let imurl = booksEntity.imurl {
                    book.imurl = imurl
                }
                
                if let url = booksEntity.url {
                    book.url = url
                }
                
                book.isFavorite = self.isFavorite(book: book)
                
                return book
            }
        } catch {
            print("Error fetching favorite books: \(error)")
        }
        
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
                    let book = Book(context: self.context)
                    book.id = id
                    book.title = title
                    book.authors = author
                    book.desc = description
                    book.imurl = imurl
                    book.url = url1
                    
                    // Set Core Data attributes
                    book.coreDataAttribute1 = "" // Replace with actual values
                    book.coreDataAttribute2 = 0  // Replace with actual values
                    
                    // Check if this book is a favorite (based on Core Data)
                    book.isFavorite = self.isFavorite(book: book)
                    
                    self.data.append(book)
                }
            }
        }.resume()
    }
    
    func isFavorite(book: Book) -> Bool {
        return book.isFavorite
    }
    
    func toggleFavorite(book: Book) {
        book.isFavorite.toggle()
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
