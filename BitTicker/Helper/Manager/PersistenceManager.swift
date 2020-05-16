//
//  PersistenceManager.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import Foundation
import CoreData

final class PersistanceManager {
    
    // Login notification name
    let nameLoginSuccess = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_SUCCESS)
    let nameLoginFailed = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_FAILED)
    let nameLoginIncorectData = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_PASSWORD_INCORRECT)
    let nameLoginNoRecordFound = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_RECORD_NOT_FOUND)
    
    // Register notification and key
    let nameRegsiterSuccess = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_SUCCESS)
    let nameRegisterFailed = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_FAILED)
    let nameAlreadyExistData = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_ALREADY_EXIST)
    
    private init() {
        
    }
    static let shared = PersistanceManager()
    
    // MARK: - Core Data stack

       lazy var persistentContainer: NSPersistentContainer = {
          
           let container = NSPersistentContainer(name: "BitTicker")
           container.loadPersistentStores(completionHandler: { (storeDescription, error) in
               if let error = error as NSError? {
                   fatalError("Unresolved error \(error), \(error.userInfo)")
               }
           })
           return container
       }()

    
    lazy var context = persistentContainer.viewContext
    
       // MARK: - Core Data Saving support

    func save(loginUser: LoginUser) {
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@", argumentArray: [loginUser.email])

            fetch.predicate = predicate

            do {

              let result = try context.fetch(fetch)
                if result != nil && result.count > 0 {
                    NotificationCenter.default.post(name: nameAlreadyExistData, object: nil)
                }
                else {
                    
                    // create user entity from coredata
                    let user = User(context: PersistanceManager.shared.context)
                    user.name = loginUser.userName
                    user.email = loginUser.email
                    user.password = loginUser.password
                    
                     let context = persistentContainer.viewContext
                     if context.hasChanges {
                         do {
                             try context.save()
                            NotificationCenter.default.post(name: nameRegsiterSuccess, object: nil)
                          
                         } catch {
                            NotificationCenter.default.post(name: nameRegisterFailed, object: nil)
                             let nserror = error as NSError
                             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                            
                         }
                     }
                }
              
            } catch {
               NotificationCenter.default.post(name: nameRegisterFailed, object: nil)
            }
       }
    
    func login(user: LoginUser)  {
           
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "email = %@", argumentArray: [user.email])

            fetch.predicate = predicate

            do {

              let result = try context.fetch(fetch)
                if result != nil && result.count > 0 {
                    
                    let data = result[0] as! NSManagedObject
                    if data != nil {
                        let pass = data.value(forKey: "password") as! String
                        let name = data.value(forKey: "name") as! String
                        if user.password == pass {
                            
                            // store loged in user data in userdefault
                            UserDefaults.standard.set(name, forKey: AppConstants.NAME_KEY)
                            UserDefaults.standard.set(true, forKey: AppConstants.IS_LOCKED_IN_KEY)
                            
                            NotificationCenter.default.post(name: nameLoginSuccess, object: nil)
                            return
                        }
                        else {
                            NotificationCenter.default.post(name: nameLoginIncorectData, object: nil)
                            return
                        }
                    }
                    else {
                        NotificationCenter.default.post(name: nameLoginNoRecordFound, object: nil)
                    }
                    
                }
                else {
                     NotificationCenter.default.post(name: nameLoginNoRecordFound, object: nil)
                }
              
            } catch {
               NotificationCenter.default.post(name: nameLoginIncorectData, object: nil)
            }
    }
}
