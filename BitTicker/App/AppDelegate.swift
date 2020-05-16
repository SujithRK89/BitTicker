//
//  AppDelegate.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var webSocketConnection: WebSocketConnectionManager!
    
    fileprivate func createWebsocketConnection() {        
        
        let url = URL(string: AppConstants.SOCKET_URL)
        webSocketConnection = WebSocketTaskConnection(url: url!)
    }
    
    func connectToSocketAndSubscribe()  {
        
        // connect to socket
        webSocketConnection.connect()
        
        do {
            
            let params: [String: String] = [
                "command":"subscribe",
                "channel":"1002"
            ]
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(params)
            let message = URLSessionWebSocketTask.Message.data(data)
            
            // subscrib to connel
            webSocketConnection!.send(data: data)
            
        } catch {
            // Maybe do something here but this shouldn't affect the app's behavior so no big deal
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create Websocket
        createWebsocketConnection()
        
        // connect to socket and Subscribe for data
        connectToSocketAndSubscribe()
        
        // handle keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        return true
    }
    
}

