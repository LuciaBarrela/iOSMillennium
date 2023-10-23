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
    var listStyle: ReminderListStyle = .today
    var filteredReminders: [Reminder] {
        return reminders.filter { listStyle.shouldInclude(date: $0.dueDate) }.sorted {
                   $0.dueDate < $1.dueDate
               }
       }
    
    //initializing names of the list styles
    let listStyleSegmentedControl = UISegmentedControl(items: [
           ReminderListStyle.today.name, ReminderListStyle.future.name, ReminderListStyle.all.name
       ])
    var headerView: ProgressHeaderView?
    //update progress dinamically
    var progress: CGFloat {
        let chunkSize = 1.0 / CGFloat(filteredReminders.count)
        let progress = filteredReminders.reduce(0.0) {
                   let chunk = $1.isComplete ? chunkSize : 0
                   return $0 + chunk
               }
        return progress 
      }


    override func viewDidLoad() {
        super.viewDidLoad()

        //background color
        collectionView.backgroundColor = .todayGradientFutureBegin
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout


        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)


        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        //registering it as a suplementaryView
        let headerRegistration = UICollectionView.SupplementaryRegistration(
                 elementKind: ProgressHeaderView.elementKind, handler: supplementaryRegistrationHandler)
        dataSource.supplementaryViewProvider = { supplementaryView, elementKind, indexPath in
                    return self.collectionView.dequeueConfiguredReusableSupplementary(
                        using: headerRegistration, for: indexPath)
                }

        
        //new add button
        let addButton = UIBarButtonItem(
                barButtonSystemItem: .add, target: self, action: #selector(didPressAddButton(_:)))
        addButton.accessibilityLabel = NSLocalizedString(
                    "Add reminder", comment: "Add button accessibility label")
        navigationItem.rightBarButtonItem = addButton
        
        
        listStyleSegmentedControl.selectedSegmentIndex = listStyle.rawValue
        listStyleSegmentedControl.addTarget(
                    self, action: #selector(didChangeListStyle(_:)), for: .valueChanged)
        navigationItem.titleView = listStyleSegmentedControl
        
        if #available(iOS 17, *) {
                   navigationItem.style = .navigator
               }

        updateSnapshot() 
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(
            _ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath
        ) -> Bool {
            let id = filteredReminders[indexPath.item].id
            pushDetailViewForReminder(withId: id)
            return false
        }
    
    //called when it's about to display the supplementary view
    override func collectionView(
           _ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView,
           forElementKind elementKind: String, at indexPath: IndexPath
       ) {
           guard elementKind == ProgressHeaderView.elementKind,
                        let progressView = view as? ProgressHeaderView
                  else {
                      return
                  }
           progressView.progress = progress
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
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = false
        listConfiguration.trailingSwipeActionsConfigurationProvider = makeSwipeActions
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
           guard let indexPath = indexPath, let id = dataSource.itemIdentifier(for: indexPath) else {
               return nil
           }
           let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
           let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
               [weak self] _, _, completion in
               self?.deleteReminder(withId: id)
               self?.updateSnapshot()
               completion(false)
           }
           return UISwipeActionsConfiguration(actions: [deleteAction])
       }
    
    //accepts the progress header view
    private func supplementaryRegistrationHandler(
          progressView: ProgressHeaderView, elementKind: String, indexPath: IndexPath
      ) {
          headerView = progressView
      }
}
