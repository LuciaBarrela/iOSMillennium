//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by Lucia Barrela on 19/10/2023.
//

import UIKit

extension ReminderViewController {
    enum Row:Hashable {
        case header(String)
        case date
        case notes
        case time
        case title
        case editableDate(Date)
        case editableText(String?)
        
        //returns a SF Symbol name for each case
        var imageName: String? {
            switch self {
            case .date: return "calendar.circle"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }
        
        //returns an image based on the image name
        var image: UIImage? {
                    guard let imageName = imageName else { return nil }
                    let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
                    return UIImage(systemName: imageName, withConfiguration: configuration)
                }
        
        //returns the text style associated with each case
        var textStyle: UIFont.TextStyle {
                    switch self {
                    case .title: return .headline
                    default: return .subheadline
                    }
                }
    }
    
}
