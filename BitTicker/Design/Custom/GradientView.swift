//
//  GradientView.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {

    @IBInspectable var startColor:   UIColor = #colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1) { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.10 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.90 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}
