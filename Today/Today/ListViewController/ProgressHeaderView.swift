//
//  ProgressHeaderView.swift
//  Today
//
//  Created by Lucia Barrela on 23/10/2023.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    var progress: CGFloat = 0 {
           didSet {
               heightConstraint?.constant = progress * bounds.height
               UIView.animate(withDuration: 0.2) { [weak self] in
                             self?.layoutIfNeeded()
                         }
           }
       }
    
    //upperview and lowerview
    private let upperView = UIView(frame: .zero)
    private let lowerView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        prepareSubviews()
        }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           heightConstraint?.constant = progress * bounds.height
           containerView.layer.masksToBounds = true
           containerView.layer.cornerRadius = 0.5 * containerView.bounds.width
       }
    
    //stablish hierarchy
    private func prepareSubviews() {
           containerView.addSubview(upperView)
           containerView.addSubview(lowerView)
           addSubview(containerView)
        
            upperView.translatesAutoresizingMaskIntoConstraints = false
            lowerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //maintaining aspect ratio
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1)
            .isActive = true
        
        //center horizontally and vertically
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        //scale 85%
        containerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        
        //anchoring
        upperView.topAnchor.constraint(equalTo: topAnchor).isActive = true
               upperView.bottomAnchor.constraint(equalTo: lowerView.topAnchor).isActive = true
               lowerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        upperView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
              upperView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
              lowerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
              lowerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //adjustable height constraints
        heightConstraint = lowerView.heightAnchor.constraint(equalToConstant: 0)
                heightConstraint?.isActive = true
        
        //background colors
        backgroundColor = .clear
              containerView.backgroundColor = .clear
              upperView.backgroundColor = .todayProgressUpperBackground
              lowerView.backgroundColor = .todayProgressLowerBackground
        
       }
}
