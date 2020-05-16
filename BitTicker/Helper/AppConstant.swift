//
//  AppConstant.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit.UIColor

struct AppConstants {

    // View controller identifier
    static let LOGIN_VC_IDENTIFIER = "loginVC"
    static let REGISTER_VC_IDENTIFIER = "registerVC"
    static let LANDING_VC_IDENTIFIER = "landingVC"
    
    // Cell identifier
    static let TICKER_CELL_IDENTIFIER = "tickerCell"
    
    // Cell name
    static let TICKER_CELL_NAME = "TickerCell"
    
    // Base URL
    static let SOCKET_URL = "wss://api2.poloniex.com"
    
    // user default key
    static let NAME_KEY = "nme"
    static let IS_LOCKED_IN_KEY = "is_locked_in"
    
    // Notification Name
    // Update date
    static let NOTIFICATION_KEY_UPDATE_DATA = "Updatedata"
    //Register
    static let NOTIFICATION_KEY_REGISTER_SUCCESS = "RegisterSuccess"
    static let NOTIFICATION_KEY_REGISTER_FAILED = "RegisterFailed"
    static let NOTIFICATION_KEY_REGISTER_ALREADY_EXIST = "UserAlreayExist"
    // Login
    static let NOTIFICATION_KEY_LOGIN_SUCCESS = "LoginSuccess"
    static let NOTIFICATION_KEY_LOGIN_FAILED = "LoginFailed"
    static let NOTIFICATION_KEY_LOGIN_PASSWORD_INCORRECT = "LoginEmailPassMissmatch"
    static let NOTIFICATION_KEY_LOGIN_RECORD_NOT_FOUND = "NoRecordFound"
    
    static let THEME_COLOR = UIColor.init(rgb: 0x3A8284)
    
}
