//
//  ChartViewVC.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import SwiftChart

class ChartViewVC: UIViewController, ChartDelegate {
    
    var selectedChart = 0
    
    let update = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_UPDATE_DATA)
    
    @IBOutlet weak var labelLeadingMarginConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var chart: Chart!
    
    @IBOutlet weak var slider1: MyCustomSlider!
    
    @IBOutlet weak var slider2: MyCustomSlider!
    
    @IBOutlet weak var slider3: MyCustomSlider!
    
    @IBOutlet weak var slider4: MyCustomSlider!
    
    @IBOutlet weak var slider5: MyCustomSlider!
    
    @IBOutlet weak var slider6: MyCustomSlider!
    
    @IBOutlet weak var slider7: MyCustomSlider!
    
    @IBOutlet weak var slider8: MyCustomSlider!
    
    
    fileprivate var labelLeadingMarginInitialConstant: CGFloat!
    
    var mTickerItem = [TickerItem]()
    var mTickerItem1 = [TickerItem]()
    
    var chartArray = Array<Dictionary<String, Any>>()
    
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        
        labelLeadingMarginInitialConstant = labelLeadingMarginConstraint.constant
                
        // create observer
        createObserver()
        
    }
    
    // create observer for listen ticker changes from service
    fileprivate func createObserver()  {
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChartViewVC.updateUI(notification:)), name: update, object: nil)
    }
    
    // Observer handler selector
    @objc func updateUI(notification: NSNotification) {
        
        DispatchQueue.main.async {
            
            if self.mTickerItem.count > 0 {
                self.mTickerItem.removeAll()
            }
            
            for index in 0..<tickerItems.count {
                
                
                var tickerValue: Float = 0
                
                if case .string(let string) = tickerItems[index] {
                    tickerValue = Float(string) ?? 0
                    
                }
                else if case .integer(let int) = tickerItems[index] {
                    tickerValue = Float(int)
                }
                
                switch index {
                case 0:
                    self.slider1.value = tickerValue
                    
                    
                    if self.chartArray.count > 50 {
                        self.chartArray.removeAll()
                    }
                    // Create data for chart
                    let date = Date()
                    let chartValue = ["date": date, "close": Double(tickerValue)] as [String : Any]
                    self.chartArray.append(chartValue)
                    break
                case 1:
                    self.slider2.value = tickerValue
                    break
                case 2:
                    self.slider3.value = tickerValue
                    break
                case 3:
                    self.slider4.value = tickerValue
                    break
                case 4:
                    self.slider5.value = tickerValue
                    break
                case 5:
                    self.slider6.value = tickerValue
                    break
                case 6:
                    self.slider7.value = tickerValue
                    break
                case 7:
                    self.slider8.value = tickerValue
                    break
                default:
                    break
                }
            }
            
            self.initializeChart()
        }
        
    }
    
    
    func initializeChart() {
        
        chart.delegate = self
        
        // Initialize data series and labels
        let stockValues = chartArray
        
        var serieData: [Double] = []
        var labels: [Double] = []
        var labelsAsString: Array<String> = []
        
        // Date formatter to retrieve the month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        
        for (i, value) in stockValues.enumerated() {
            
            serieData.append(value["close"] as! Double)
            
            // Use only one label for each month
            let month = Int(dateFormatter.string(from: value["date"] as! Date))!
            let monthAsString:String = dateFormatter.monthSymbols[month - 1]
            if (labels.count == 0 || labelsAsString.last != monthAsString) {
                labels.append(Double(i))
                labelsAsString.append(monthAsString)
            }
        }
        
        let series = ChartSeries(serieData)
        series.area = true
        
        // Configure chart layout
        
        chart.lineWidth = 0.5
        chart.labelFont = UIFont.systemFont(ofSize: 12)
        chart.xLabels = labels
        chart.xLabelsFormatter = { (labelIndex: Int, labelValue: Double) -> String in
            return labelsAsString[labelIndex]
        }
        chart.xLabelsTextAlignment = .center
        chart.yLabelsOnRightSide = true
        // Add some padding above the x-axis
        chart.minY = serieData.min()! - 5
        
        chart.add(series)
        
    }
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            label.text = numberFormatter.string(from: NSNumber(value: value))
            
            // Align the label to the touch left position, centered
            var constant = labelLeadingMarginInitialConstant + left - (label.frame.width / 2)
            
            // Avoid placing the label on the left of the chart
            if constant < labelLeadingMarginInitialConstant {
                constant = labelLeadingMarginInitialConstant
            }
            
            // Avoid placing the label on the right of the chart
            let rightMargin = chart.frame.width - label.frame.width
            if constant > rightMargin {
                constant = rightMargin
            }
            
            labelLeadingMarginConstraint.constant = constant
            
        }
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        label.text = ""
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
        
    }
    
}
