//
//  TextFieldContentView.swift
//  Today
//
//  Created by Lucia Barrela on 19/10/2023.
//

import UIKit

class TextFieldContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        var text: String? = ""
        
        
        func makeContentView() -> UIView & UIContentView {
            return TextFieldContentView(self)
        }
    }
    
    let textField = UITextField()
    
    //calls the new configure method to the property
    var configuration: UIContentConfiguration {
           didSet {
               configure(configuration: configuration)
           }
       }
    
    override var intrinsicContentSize: CGSize {
            CGSize(width: 0, height: 44)
        }
    
    
    //add the text subview and initialize its properties
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.clearButtonMode = .whileEditing
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //function that accepts a UIContentConfiguration
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
       }
   }

extension UICollectionViewListCell {
    
    func textFieldConfiguration() -> TextFieldContentView.Configuration {
           TextFieldContentView.Configuration()
       }
}
