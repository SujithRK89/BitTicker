//
//  ViewController.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import IQKeyboardManagerSwift

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var ivLogo: UIImageView!
    
    @IBOutlet weak var tfUserName: MDCOutlinedTextField!
    
    @IBOutlet weak var tfPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    // Notification Name
    let nameLoginSuccess = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_SUCCESS)
    let nameLoginFailed = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_FAILED)
    let nameLoginIncorectData = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_PASSWORD_INCORRECT)
    let nameLoginNoRecordFound = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_LOGIN_RECORD_NOT_FOUND)
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize view components
        initView()
        
    }
    
    func initView() {
        
        // register Text field Delegates
        registerDelegates()
        
        // Setup UI components
        setupUiComponents()
        
        // Create Login Observers
        createObservers()
        
    }
    
    // regsietr Delegates and listen
    func registerDelegates() {
        
        tfUserName.delegate = self
        tfPassword.delegate = self
    }
    
    // setUp Ui Components
    func setupUiComponents()  {
        
        // setup User Name textfield
        tfUserName.label.text = "Email"
        tfUserName.placeholder = "john@gmail.com"
        tfUserName.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfUserName.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfUserName.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfUserName.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfUserName.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfUserName.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfUserName.clearButtonMode = .always
        tfUserName.clearButtonMode = .whileEditing
        
        // Setup Password textfield
        tfPassword.label.text = "Password"
        tfPassword.placeholder = "Your Password"
        tfPassword.autocorrectionType = .no
        tfPassword.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfPassword.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfPassword.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfPassword.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.clearButtonMode = .always
        tfPassword.clearButtonMode = .whileEditing
        
        
        // make logo rounded
//        ivLogo.makeRounded()
        
    }
    
    func createObservers() {
        
        // login success
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.loginListener(notification:)), name: nameLoginSuccess, object: nil)
        
        // login Failed
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.loginListener(notification:)), name: nameLoginFailed, object: nil)
        
        // login username password mismatch
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.loginListener(notification:)), name: nameLoginIncorectData, object: nil)
        
        // login Record not found
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.loginListener(notification:)), name: nameLoginNoRecordFound, object: nil)
    }
    
    @objc func loginListener(notification: NSNotification) {
        
        switch notification.name {
        case nameLoginSuccess:
            // make textfields nil
            tfUserName.text = nil
            tfPassword.text = nil
            
            // navigate to Landing page
            presentLandingVC()
            break
        case nameLoginNoRecordFound:
            
            // make textfields nil
            tfUserName.text = nil
            tfPassword.text = nil
            
            // Record not found
            let alertController = UIAlertController(title: nil, message: "Not Registered with provided email, Register with us and try login", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                // present register
                self.presentSignUp()
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            break
        case nameLoginIncorectData:
            
            // make textfields nil
            tfPassword.text = nil
            
            // username or password missmatch
            alert(message: "Please check your Username and Password")
            break
        case nameLoginFailed:
            // make textfields nil
            tfUserName.text = nil
            tfPassword.text = nil
            
            // login failed with some other reason
            alert(message: "Something went wrong, Try Again")
            break
        default:
            break
        }
    }
    
    // login button action
    @IBAction func onLoginClick(_ sender: Any) {
        IQKeyboardManager.shared.resignFirstResponder()
        // validate user inputs and attept login
        self.validate()
        
    }
    
    // signup button action
    @IBAction func onSignUpClick(_ sender: Any) {
        IQKeyboardManager.shared.resignFirstResponder()
        // navigate to Register VC
        presentSignUp()
    }
    
    func presentSignUp() {
        let regsiterVC = self.storyboard?.instantiateViewController(withIdentifier: AppConstants.REGISTER_VC_IDENTIFIER) as! RegisterVC
        // make vc full screen
        regsiterVC.modalPresentationStyle = .fullScreen
        self.present(regsiterVC, animated: true, completion: nil)
    }
    
    // forgot password button action
    @IBAction func onForgotPasswordClik(_ sender: Any) {
        
        // show message
        alert(message: "Forgot Password Not Implemented")
    }
    
    // validate user inputs
    func validate() {
        do {
            let email = try tfUserName.validatedText(validationType: ValidatorType.email)
            let password = try tfPassword.validatedText(validationType: ValidatorType.password)
            // attempt login
            attemptLogin(email: email, password: password)
        } catch(let error) {
            alert(message: (error as! ValidationError).message)
        }
    }
    
    // attempt login with user name and password
    func attemptLogin(email: String, password: String) {
        
        // check for the same email in local db. If exist match password user entered with password in db. Password matches give access permission else show alert to user
        
        let user = LoginUser(userName: "", email: email, password: password)
        PersistanceManager.shared.login(user: user)
        
    }
    
    // navigate to Landing VC
    func presentLandingVC()  {
        
        let landingVC = self.storyboard?.instantiateViewController(withIdentifier: AppConstants.LANDING_VC_IDENTIFIER) as! LandingVC
        // make vc full screen
        landingVC.modalPresentationStyle = .fullScreen
        self.present(landingVC, animated: true, completion: nil)
        
    }
    
}

// implement delegates
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}


