//
//  InternalSlider.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import UIKit

class BaseSlider: UISlider {

    var increment: Float = 0
    
    var roundedValue: Float {
        get {
            return round(super.value, to: increment)
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.frame.size = self.intrinsicContentSize
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        addTarget(self, action: #selector(endSliding), for: .touchUpInside)
        addTarget(self, action: #selector(endSliding), for: .touchUpOutside)
    }
    
    @objc private func endSliding() {
        setValue(round(super.value, to: increment), animated: true)
        sendActions(for: .valueChanged)
    }
}

fileprivate func round(_ value: Float, to increment: Float) -> Float {
    if increment == 0 {
        return value
    }
    return increment * Float(round(value / increment))
}
