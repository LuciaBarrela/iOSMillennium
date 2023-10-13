//
//  ViewController.swift
//  Today
//
//  Created by Lucia Barrela on 13/10/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout //assign the list layout to the collection view layout
    }
    
    // new list configuration
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear //background clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

