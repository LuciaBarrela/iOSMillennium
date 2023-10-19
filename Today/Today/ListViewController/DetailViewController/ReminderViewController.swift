//
//  ReminderViewController.swift
//  Today
//
//  Created by Lucia Barrela on 18/10/2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    //variables/properties
    var reminder: Reminder
    var workingReminder: Reminder
    private var dataSource: DataSource!

    //initializing
    init(reminder: Reminder) {
        self.reminder = reminder
               self.workingReminder = reminder
               var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
               listConfiguration.showsSeparators = false
               listConfiguration.headerMode = .firstItemInSection
               let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
               super.init(collectionViewLayout: listLayout)
           }
    
    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }
    
    //Overriding the viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
                    (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
                    return collectionView.dequeueConfiguredReusableCell(
                        using: cellRegistration, for: indexPath, item: itemIdentifier)
                }
        
        if #available(iOS 17, *) {
                    navigationItem.style = .navigator
                }
        
        navigationItem.title = NSLocalizedString("Reminder", comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem

        
        updateSnapshotForViewing()
        
            }
    
    //calls the superclass implementation
    override func setEditing(_ editing: Bool, animated: Bool) {
           super.setEditing(editing, animated: animated)
           if editing {
               prepareForEditing()
           } else {
               prepareForViewing()
           }
       }

    
    //method that accepts a cell, an index path and a row
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        //switch statement using a tuple
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.title, .editableText(let title)):
            cell.contentConfiguration = titleConfiguration(for: cell, with: title)
        case (.date, .editableDate(let date)):
                  cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        case (.notes, .editableText(let notes)):
                  cell.contentConfiguration = notesConfiguration(for: cell, with: notes)
        default:
                    fatalError("Unexpected combination of section and row.")
                }
       
        cell.tintColor = .todayPrimaryTint
}
    
    //to hold the editing
    private func prepareForEditing() {
        
        if workingReminder != reminder {
                   reminder = workingReminder
               }
          
           updateSnapshotForEditing()
       }


    
   
    //new update snapshot
    private func updateSnapshotForEditing() {
            var snapshot = Snapshot()
            snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems(
                   [.header(Section.title.name), .editableText(reminder.title)], toSection: .title)
        snapshot.appendItems(
                  [.header(Section.date.name), .editableDate(reminder.dueDate)], toSection: .date)
              snapshot.appendItems(
                  [.header(Section.notes.name), .editableText(reminder.notes)], toSection: .notes)
            snapshot.appendItems([.header(Section.date.name)], toSection: .date)
            snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
        }
    
    private func prepareForViewing() {
        if workingReminder != reminder {
                   reminder = workingReminder
               }
           updateSnapshotForViewing()
       }
    
    //function to update Snapshot
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems(
                   [Row.header(""), Row.title, Row.date, Row.time, Row.notes], toSection: .view)
        dataSource.apply(snapshot)
        }
    
    //accepts an index path and returns a Section
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        //instance of Section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        
        return section
        }
    }
