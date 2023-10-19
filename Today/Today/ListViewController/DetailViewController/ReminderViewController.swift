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
    private var dataSource: DataSource!

    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        listConfiguration.headerMode = .firstItemInSection //header mode
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
                    updateSnapshotForEditing()
                } else {
                    updateSnapshotForViewing()
                }
        }

    
    //method that accepts a cell, an index path and a row
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        //switch statement using a tuple
        switch (section, row) {
        case (_, .header(let title)):
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = title
            cell.contentConfiguration = contentConfiguration
        case (.view, _):
            var contentConfiguration = cell.defaultContentConfiguration()
                    contentConfiguration.text = text(for: row)
                    contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
                    contentConfiguration.image = row.image
            cell.contentConfiguration = contentConfiguration
                default:
                    fatalError("Unexpected combination of section and row.")
                }
       
        cell.tintColor = .todayPrimaryTint
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
    
    //new update snapshot
    private func updateSnapshotForEditing() {
            var snapshot = Snapshot()
            snapshot.appendSections([.title, .date, .notes])
            snapshot.appendItems([.header(Section.title.name)], toSection: .title)
            snapshot.appendItems([.header(Section.date.name)], toSection: .date)
            snapshot.appendItems([.header(Section.notes.name)], toSection: .notes)
        dataSource.apply(snapshot)
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
