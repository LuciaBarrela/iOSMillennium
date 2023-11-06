//
//  User.swift
//  ToDoList
//
//  Created by Lucia Barrela on 03/11/2023.
//

import Foundation

struct User: Codable

    {
        let id: String
        let name: String
        let email: String
        let joined: TimeInterval
    }
