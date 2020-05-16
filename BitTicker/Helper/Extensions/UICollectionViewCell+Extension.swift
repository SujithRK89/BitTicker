//
//  UICollectionViewCell+Extension.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import UIKit.UICollectionViewCell

extension UICollectionViewCell {
    func shadowDecorate() {
       self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
    }
}
