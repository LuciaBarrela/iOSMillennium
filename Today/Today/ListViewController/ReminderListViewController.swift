//
//  ViewController.swift
//  Today
//
//  Created by Lucia Barrela on 18/10/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData


    override func viewDidLoad() {
        super.viewDidLoad()


        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout


        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)


        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        //new add button
        let addButton = UIBarButtonItem(
                barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString(
                    "Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        if #available(iOS 17, *) {
                   navigationItem.style = .navigator
               }

        updateSnapshot() 
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(
            _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
        ) -> Bool {
            let id = reminders[indexPath.item].id
            pushDetailViewForReminder(withId: id)
            return false
        }
    
    //accepts a reminder identifier
    func pushDetailViewForReminder(withId id: Reminder.ID) {
            let reminder = reminder(withId: id)
            let viewController = ReminderViewController(reminder: reminder) { [weak self] reminder in
                self?.updateReminder(reminder)
                self?.updateSnapshot(reloading: [reminder.id])
            }
            navigationController?.pushViewController(viewController, animated: true)
        }



    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
