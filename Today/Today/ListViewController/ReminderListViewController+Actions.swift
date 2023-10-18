//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Lucia Barrela on 18/10/2023.
//

import UIKit

extension ReminderListViewController {
    //@objc attribute makes this method available to Objective-C code
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
}
