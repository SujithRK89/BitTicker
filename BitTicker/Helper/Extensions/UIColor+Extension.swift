//
//  UIColor+Extension.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import UIKit.UIColor

extension UIColor {
    
    static var mGreen: UIColor {
        return UIColor(red: 0, green: 48.2, blue: 26.3, alpha: 1)
    }
    
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}
