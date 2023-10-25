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


class Book: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var authors: String
    @NSManaged var desc: String
    @NSManaged var imurl: String
    @NSManaged var url: String
    @NSManaged var isFavorite: Bool
}


class getData: ObservableObject {
    @Published var data: [Book] = []

    // Add a reference to the managed object context
    private let context = PersistenceController.shared.container.viewContext

    init() {
        // Fetch existing favorite books from Core Data
        do {
            let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "isFavorite == true")
            self.data = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite books: \(error)")
        }

        // Fetch new books from the API
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

                    // Check if this book is a favorite (based on Core Data)
                    book.isFavorite = self.isFavorite(book: book)

                    self.data.append(book)
                }
            }
        }.resume()
    }

    // Function to check if a book is a favorite
    func isFavorite(book: Book) -> Bool {
        return book.isFavorite
    }

    // Function to toggle the favorite status of a book
    func toggleFavorite(book: Book) {
        book.isFavorite.toggle()
        saveContext()
    }

    // Function to save the managed object context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
