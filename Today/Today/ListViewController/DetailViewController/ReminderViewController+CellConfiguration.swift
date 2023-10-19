//
//  ReminderViewController+CellConfiguration.swift
//  Today
//
//  Created by Lucia Barrela on 19/10/2023.
//

import UIKit

extension ReminderViewController {
    
    //accepts a cell and a row and returns UIListContentConfiguration
    func defaultConfiguration(for cell: UICollectionViewListCell, at row: Row)
       -> UIListContentConfiguration
       {
           
           var contentConfiguration = cell.defaultContentConfiguration()
                  contentConfiguration.text = text(for: row)
                  contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
                  contentConfiguration.image = row.image
           return contentConfiguration 
       }
    
    func headerConfiguration(for cell: UICollectionViewListCell, with title: String)
        -> UIListContentConfiguration
        {
            
            var contentConfiguration = cell.defaultContentConfiguration()
                  contentConfiguration.text = title
            return contentConfiguration
        }
    
    //func accepts a cell and a title and returns a TextFieldContentView.Configuration
    func titleConfiguration(for cell: UICollectionViewListCell, with title: String?)
        -> TextFieldContentView.Configuration
        {
            var contentConfiguration = cell.textFieldConfiguration()
            contentConfiguration.text = title
            contentConfiguration.onChange = { [weak self] title in
                       self?.workingReminder.title = title
                   }
            
                   return contentConfiguration
        }
    
    //date configuration functions below
    func dateConfiguration(for cell: UICollectionViewListCell, with date: Date)
       -> DatePickerContentView.Configuration
       {
           var contentConfiguration = cell.datePickerConfiguration()
           contentConfiguration.date = date
           contentConfiguration.onChange = { [weak self] dueDate in
                       self?.workingReminder.dueDate = dueDate
                   }
           return contentConfiguration
       }


    //notes configuration functions below
       func notesConfiguration(for cell: UICollectionViewListCell, with notes: String?)
       -> TextViewContentView.Configuration
       {
           var contentConfiguration = cell.textViewConfiguration()
           contentConfiguration.text = notes
           return contentConfiguration
       }

    
    
    //returns the text associated with the given row
    func text(for row: Row) -> String? {
            switch row {
            case .date: return reminder.dueDate.dayText
            case .notes: return reminder.notes
            case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
            case .title: return reminder.title
            default: return nil
            }
        }
    
    
}
