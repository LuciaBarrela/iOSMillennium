//
//  BooksEntity+CoreDataProperties.swift
//  iOsBooks
//
//  Created by Lucia Barrela on 25/10/2023.
//
//

import Foundation
import CoreData


extension BooksEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BooksEntity> {
        return NSFetchRequest<BooksEntity>(entityName: "BooksEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var authors: String?
    @NSManaged public var desc: String?
    @NSManaged public var imurl: String?
    @NSManaged public var url: String?
    @NSManaged public var isFavorite: Bool

}

extension BooksEntity : Identifiable {

}
