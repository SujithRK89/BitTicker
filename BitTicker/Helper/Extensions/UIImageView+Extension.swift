//
//  UIImageView+Extension.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 4
        self.layer.masksToBounds = false
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
