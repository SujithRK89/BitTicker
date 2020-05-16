//
//  DefaultVC.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import IQKeyboardManagerSwift

var compareUserInput: Double = 0.0

class DefaultVC: UIViewController {
    
    @IBOutlet weak var tfCompare: MDCOutlinedTextField!
    
    @IBOutlet weak var tickerCV: UICollectionView!
    
    @IBOutlet weak var btnGo: UIButton!
    
    
    // Dummy value to populate in list as title
    let titleArray = ["BTC", "ETH", "TRX", "XRP", "LTC", "NEO", "STR", "XMR", "BCHSV", "BCHABC"]
    // Dummy value to populate in list as percentage
    let priceArray = ["10%", "20%", "50%", "2%", "43%", "15%", "25%", "70%", "33%", "60%"]
    // Current Ticker value
    var mTickerItem = [TickerItem]()
    
    let update = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_UPDATE_DATA)
    
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
        mTickerItem.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // regsier delegate
        registerDelegate()
        
        // register Cells
        regsiterCellForCollectionView()
        
        // create observer
        createObserver()
        
        // setup Compare textfield
        setUpCompareTF()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    fileprivate func setUpCompareTF() {
        tfCompare.label.text = "Compare With"
        tfCompare.placeholder = "Enter Value here"
        tfCompare.setOutlineColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        tfCompare.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfCompare.setTextColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        tfCompare.setTextColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .editing)
        tfCompare.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfCompare.setFloatingLabelColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        tfCompare.clearButtonMode = .always
        tfCompare.clearButtonMode = .whileEditing
        tfCompare.keyboardType = .numberPad
        tfCompare.delegate = self
        
    }
    
    fileprivate func registerDelegate()  {
        self.tickerCV.delegate = self
        self.tickerCV.dataSource = self
    }
    
    fileprivate func regsiterCellForCollectionView()  {
        self.tickerCV.register(UINib(nibName: AppConstants.TICKER_CELL_NAME, bundle: nil), forCellWithReuseIdentifier: AppConstants.TICKER_CELL_IDENTIFIER)
    }
    
    // create observer for listen ticker changes from service
    fileprivate func createObserver()  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(DefaultVC.updateUI(notification:)), name: update, object: nil)
    }
    
    // Observer handler selector
    @objc func updateUI(notification: NSNotification) {
        
        DispatchQueue.main.async {
            
            if self.mTickerItem.count > 0 {
                self.mTickerItem.removeAll()
            }
            
            for index in 0..<tickerItems.count {
                
                var tickerValue: String? = nil
                
                if case .string(let string) = tickerItems[index] {
                    tickerValue = string as? String
                }
                else if case .integer(let int) = tickerItems[index] {
                    let myString = int as? Int
                    tickerValue = "\(myString ?? 0)"
                }
                
                self.mTickerItem.append(TickerItem(title: self.titleArray[index], price: self.priceArray[index], value: tickerValue!))
            }
            
            if self.mTickerItem.count > 2 {
                self.tickerCV.reloadData()
            }
        }
        
    }
    
    // compare go button action
    @IBAction func goBtnClick(_ sender: Any) {
        
        IQKeyboardManager.shared.resignFirstResponder()
        
        if !tfCompare.text!.isEmpty {
            compareUserInput = Double(tfCompare.text?.trimmingCharacters(in: .whitespaces) ?? "0") ?? 0
        }
        else {
            showAlert(for: "Enter a value to compare")
        }
    }
    
    // notify alert with user
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension DefaultVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppConstants.TICKER_CELL_IDENTIFIER, for: indexPath) as! TickerCell
        if mTickerItem.count > 0 {
            cell.setData(value: mTickerItem[indexPath.row])
            cell.shadowDecorate()
        }
        
        return cell
    }
    
    
}

extension DefaultVC: UICollectionViewDelegateFlowLayout {
    
    // setup spacing for items
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}

extension DefaultVC: UITextFieldDelegate {
    
    // restrict text field to digit only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.resignFirstResponder()
        compareUserInput = 0.0
      return true
    }
    
}
