//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Lucia Barrela on 18/10/2023.
//

import UIKit

extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    //new method updates the snapshot
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map { $0.id })
        //if the array is not empty, reload the reminders for the identifiers
        if !ids.isEmpty {
                   snapshot.reloadItems(ids)
               }
        dataSource.apply(snapshot)

    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        
        let reminder = reminders[indexPath.item]
               var contentConfiguration = cell.defaultContentConfiguration()
               contentConfiguration.text = reminder.title
               contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(
                   forTextStyle: .caption1)
               cell.contentConfiguration = contentConfiguration
        
        //calling the new button
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [
                   .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)
               ]

        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    //funçoes para adicionar reminders
    func reminder(withId id: Reminder.ID) -> Reminder {
            let index = reminders.indexOfReminder(withId: id)
            return reminders[index]
        }
    
    func updateReminder(_ reminder: Reminder) {
            let index = reminders.indexOfReminder(withId: reminder.id)
            reminders[index] = reminder
        }
    
    //method that accepts a Reminder.ID
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
        }
    
    private func doneButtonConfiguration(for reminder: Reminder)
        -> UICellAccessory.CustomViewConfiguration
        {
            let symbolName = reminder.isComplete ? "circle.fill" : "circle"
            let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
            let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
            //use new ReminderDoneButton class
            let button = ReminderDoneButton()
            button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
            button.id = reminder.id
            button.setImage(image, for: .normal)
            return UICellAccessory.CustomViewConfiguration(
                       customView: button, placement: .leading(displayed: .always))
        }
}
