//
//  ReminderViewController.swift
//  Today
//
//  Created by Lucia Barrela on 18/10/2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Int, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Row>

    //variables/properties
    var reminder: Reminder
    private var dataSource: DataSource!

    
    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
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

        
        updateSnapshot()
        
            }
    
    //method that accepts a cell, an index path and a row
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        var contentConfiguration = cell.defaultContentConfiguration()
                contentConfiguration.text = text(for: row)
                contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
                contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
}

    
    //returns the text associated with the given row
    func text(for row: Row) -> String? {
            switch row {
            case .date: return reminder.dueDate.dayText
            case .notes: return reminder.notes
            case .time: return reminder.dueDate.formatted(date: .omitted, time: .shortened)
            case .title: return reminder.title
            }
        }
    
    //function to update Snapshot
    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([Row.title, Row.date, Row.time, Row.notes], toSection: 0)
        dataSource.apply(snapshot)
        }
    }
