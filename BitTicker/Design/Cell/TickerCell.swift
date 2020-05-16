//
//  TickerCell.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit

class TickerCell: UICollectionViewCell {
    
    @IBOutlet weak var lTitle: UILabel!
    
    @IBOutlet weak var lPrice: UILabel!
    
    @IBOutlet weak var lPercentage: UILabel!
    
    @IBOutlet weak var ivIndicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(value: TickerItem) {
        
        // set title value
        lTitle.text = value.title
        
        // updated ticker value and check for changes
        if value.value != nil {
            
            lPrice.text = value.value
            
            if compareUserInput == 0 {
                // update ui for negative values
                if value.value.hasPrefix("-") {
                    
                    ivIndicator.image = UIImage(named: "arrowDown")
                    ivIndicator.tintColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                    lPrice.textColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                }
                else if (value.value == "0"){
                    
                    ivIndicator.image = nil
                    lPrice.textColor = .black
                }
                else {
                    ivIndicator.image = UIImage(named: "arrowUp")
                    ivIndicator.tintColor = #colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1)
                    lPrice.textColor = #colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1)
                }
            }
            else {
                
                let mValueToCompare = Double(value.value) ?? 0
                
                if (mValueToCompare == 0 || mValueToCompare == compareUserInput){
                    
                    ivIndicator.image = nil
                    lPrice.textColor = .black
                    
                    ivIndicator.image = UIImage(named: "arrowDown")
                    ivIndicator.tintColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                    lPrice.textColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                }
                else if mValueToCompare < compareUserInput {
                    
                    ivIndicator.image = UIImage(named: "arrowDown")
                    ivIndicator.tintColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                    lPrice.textColor = #colorLiteral(red: 0.8, green: 0, blue: 0, alpha: 1)
                }
                else {
                    ivIndicator.image = UIImage(named: "arrowUp")
                    ivIndicator.tintColor = #colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1)
                    lPrice.textColor = #colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1)
                }
            }
        }
        // dummy percentage value
        lPercentage.text = value.price
    }
    
}
