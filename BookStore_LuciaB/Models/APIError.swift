//
//  APIError.swift
//  Bookstore_Lucia
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Foundation

//enum of various API
enum APIError: Error {
    case requestFailed
    case invalidResponse
    case parsingError
    case networkError(Error)
}
