//
//  ContentView.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//


import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
import CoreData

struct ContentView: View {
    @ObservedObject var booksData = getData()
    @State var show = false
    @State var selectedURL: String?
    @State private var isLoadingMore = false
    @State private var showFavoritesOnly = false

    var columns: [GridItem] = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)] // 2 columns

    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showFavoritesOnly, label: {
                    Text("Show Favorites Only")
                })
                .padding(.horizontal, 20)
                .padding(.top, 10)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(booksData.data, id: \.id) { book in
                            if !showFavoritesOnly || book.isFavorite {
                                NavigationLink(destination: BookDetailView(book: book, booksData: booksData)) {
                                    BookCellView(book: book)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }

    func loadMoreBooks() {
        isLoadingMore = true
        let startIndex = booksData.data.count
        let url = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=\(startIndex)"
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
                    self.booksData.data.append(Book(id: id, title: title, authors: author, desc: description, imurl: imurl, url: url1))
                    isLoadingMore = false
                }
            }
        }.resume()
    }
}

struct WebView: UIViewRepresentable {
    var url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
