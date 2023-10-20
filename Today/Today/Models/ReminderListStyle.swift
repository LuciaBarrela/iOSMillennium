//
//  ReminderListStyle.swift
//  Today
//
//  Created by Lucia Barrela on 20/10/2023.
//

import Foundation

enum ReminderListStyle: Int {
        case today
        case future
        case all
    
    //returns the name of each style
    var name: String {
           switch self {
           case .today:
               return NSLocalizedString("Today", comment: "Today style name")
           case .future:
               return NSLocalizedString("Future", comment: "Future style name")
           case .all:
               return NSLocalizedString("All", comment: "All style name")
           }
       }
    
    //accepts a Date paremeter and returns a Bool value
    func shouldInclude(date: Date) -> Bool {
        let isInToday = Locale.current.calendar.isDateInToday(date)
               switch self {
               case .today:
                   return isInToday
               case .future:
                   return (date > Date.now) && !isInToday
               case .all:
                   return true
               }
           }
       }
