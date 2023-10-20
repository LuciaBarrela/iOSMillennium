//
//  URLImageView.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 20/10/2023.
//

import SwiftUI
import UIKit

struct URLImageView: View {
    @StateObject private var imageLoader: ImageLoader

    init(url: String?) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if imageLoader.isLoading {
            ProgressView()
        } else if let uiImage = UIImage(data: imageLoader.data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            // Display a placeholder image or error message
            Text("Image not available")
        }
    }
}


class ImageLoader: ObservableObject {
    @Published var data = Data()
    @Published var isLoading = false

    init(url: String?) {
        guard let urlString = url, let url = URL(string: urlString) else {
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async { // Publish changes on the main thread
                    self.data = data
                    self.isLoading = false
                }
            } else if let error = error {
                print("Image download error: \(error.localizedDescription)")
                DispatchQueue.main.async { // Also on the main thread
                    self.isLoading = false
                }
            }
        }.resume()
    }
}






