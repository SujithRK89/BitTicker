//
//  UIViewController+Extension.swift
//  BitTicker
//
//  Created by Sujith RK on 16/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import UIKit.UIViewController

extension UIViewController {
  func alert(message: String, title: String = "Info") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}
