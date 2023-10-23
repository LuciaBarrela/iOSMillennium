//
//  CAGradientLayer+ListStyle.swift .swift
//  Today
//
//  Created by Lucia Barrela on 23/10/2023.
//

import UIKit

//background gradient
extension CAGradientLayer {
    //accepts parameters for style and frame and returns CAGradientLayer
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors(for: style)
        layer.frame = frame
        return layer 
        
       }
    private static func colors(for style: ReminderListStyle) -> [CGColor] {
        let beginColor: UIColor
        let endColor: UIColor
        
        switch style {
                case .all:
                    beginColor = .todayGradientAllBegin
                    endColor = .todayGradientAllEnd
                case .future:
                    beginColor = .todayGradientFutureBegin
                    endColor = .todayGradientFutureEnd
                case .today:
                    beginColor = .todayGradientTodayBegin
                    endColor = .todayGradientTodayEnd
                }
        
        return [beginColor.cgColor, endColor.cgColor]
    }
    
}
