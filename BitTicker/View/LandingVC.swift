//
//  LandingVC.swift
//  BitTicker
//
//  Created by Sujith RK on 15/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

// current ticker data
var tickerItems = [Ticker]()

class LandingVC: UIViewController, WebSocketConnectionDelegate {
    
    @IBOutlet weak var defaultView: UIView!
    
    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var labelWelcome: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var userNameView: UIView!
    
    @IBOutlet weak var labelUserNameFirst: UILabel!
    
    
    // Socket task
    var webSocketTask: URLSessionWebSocketTask?  = nil
    
    var isNetworkOffline = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize view comonents
        initView()
        
        
    }
    
    func initView()  {
        
        // Register Live data reciever
        registerReciever()
        
        // setup welcome message
        setupWelcomemessage()
        
        // update segment control text color
        setupSegmentTextColor()
        
        // make name view cirle
//        userNameView.makeCircleWithBorder()
        
        // create reachability observer
        createReachabilityObserver()
        
        // Monitor reachability change
        Reach().monitorReachabilityChanges()
        
    }
    
    func createReachabilityObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(LandingVC.networkStatusChanged(_:)), name: Notification.Name(rawValue: AppConstants.NOTIFICATION_KEY_RECHABILITY_STATUS), object: nil)
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
       
            let status = Reach().connectionStatus()
            switch status {
            case .unknown, .offline:
                isNetworkOffline = true
                alert(message: "Check your network Settings and try again.", title: "No Internet Connection")
                break
            case .online(.wwan):
                showNetworkDetected()
                break
            case .online(.wiFi):
                showNetworkDetected()
                break
            }
    
        
    }
    
    func showNetworkDetected() {
        
        if isNetworkOffline {
            let alertController = UIAlertController(title: nil, message: "Network connection is active now, Reconnect", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                // Reconnect
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.connectToSocketAndSubscribe()
                
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            isNetworkOffline = false
        }
    }
    
    func setupSegmentTextColor() {
        
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
    }
    
    func registerReciever() {
        
        // add delegate for listen for data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var aVariable = appDelegate.webSocketConnection
        aVariable?.delegate = self
        
    }
    
    // set welcome message with user name
    func setupWelcomemessage()  {
        
        // get current user name from user default
        let name: String? = UserDefaults.standard.string(forKey: AppConstants.NAME_KEY) ?? ""
        
        if !name!.isEmpty {
            labelName.text = name
//            labelUserNameFirst.text = String((name?.first)!)
        }
    }
    
    func onConnected(connection: WebSocketConnectionManager) {
        print("Connected")
    }
    
    func onDisconnected(connection: WebSocketConnectionManager, error: Error?) {
        if let error = error {
            print("Disconnected with error:\(error)")
        } else {
            print("Disconnected normally")
        }
    }
    
    func onError(connection: WebSocketConnectionManager, error: Error) {
        print("Connection error:\(error)")
    }
    
    //   Observe for data change
    func onMessage(connection: WebSocketConnectionManager, text: String) {
        
        
        do {
            // Parse data from socket
            let ticker = try BaseTicker(text)
            
            // loop through main array and get ticker array of values
            ticker.forEach({ (element) in
                
                if case .integer(let string) = element {
                    //                        case for integer value
                }
                if case .unionArray(let array) = element {
                    
                    tickerItems = array
                    
                    if tickerItems.count > 0 {
                        // Notify data updated
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_UPDATE_DATA), object: nil)
                    }
                    
                }
                if case .null = element {
                    //                        case for null value
                }
            })
            
        }
        catch {
            
        }
        
    }
    
    func onMessage(connection: WebSocketConnectionManager, data: Data) {
        print("Data message: \(data)")
    }
    
    
    // Toggle between views
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        
        IQKeyboardManager.shared.resignFirstResponder()
        
        if sender.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                self.defaultView.alpha = 1
                self.customView.alpha = 0
            
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.defaultView.alpha = 0
                self.customView.alpha = 1
                
            })
        }
                
    }
    
    // Logout action
    @IBAction func onLogoutBtnclick(_ sender: Any) {
        
        // Remove user details from UserDefault
        UserDefaults.standard.removeObject(forKey: AppConstants.IS_LOCKED_IN_KEY)
        UserDefaults.standard.removeObject(forKey: AppConstants.NAME_KEY)
        
        // Logout and present login vc
        presentLoginVC()
    }
    
    // navigate to Landing VC
    func presentLoginVC()  {
        
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: AppConstants.LOGIN_VC_IDENTIFIER) as! LoginVC
        // make vc full screen
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        
    }
    
}
