//
//  ReminderViewController+Section.swift
//  Today
//
//  Created by Lucia Barrela on 19/10/2023.
//

import Foundation


extension ReminderViewController {
    enum Section: Int, Hashable {
                case view
                case title
                case date
                case notes
        
        //name: computes heading text for each section
        var name: String {
                    switch self {
                    case .view: return ""
                    case .title:
                        return NSLocalizedString("Title", comment: "Title section name")
                    case .date:
                        return NSLocalizedString("Date", comment: "Date section name")
                    case .notes:
                        return NSLocalizedString("Notes", comment: "Notes section name")
                    }
                }
        
    }
}
