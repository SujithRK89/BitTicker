//
//  RegisterVC.swift
//  BitTicker
//
//  Created by Sujith RK on 14/05/2020.
//  Copyright © 2020 Sujith RK. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields

class RegisterVC: UIViewController {
    
    @IBOutlet weak var ivLogo: UIImageView!
    
    @IBOutlet weak var tfName: MDCOutlinedTextField!
    
    @IBOutlet weak var tfEmail: MDCOutlinedTextField!
    
    @IBOutlet weak var tfPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var tfConfirmPassword: MDCOutlinedTextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    let nameRegsiterSuccess = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_SUCCESS)
    let nameRegisterFailed = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_FAILED)
    let nameAlreadyExistData = NSNotification.Name(rawValue: AppConstants.NOTIFICATION_KEY_REGISTER_ALREADY_EXIST)
    
    deinit {
        // remove observers
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize view components
        initViews()
        
    }
    
    func initViews()  {
        
        // register textfield Delegate
        registerTFDelegate()
        
        // Setup UI components
        setUpUiComponents()
        
        // Create Login Observers
        createObservers()
        
    }
    
    // create and listen
    func createObservers() {
        
        // Register success
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.registerListener(notification:)), name: nameRegsiterSuccess, object: nil)
        
        // Register Failed
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.registerListener(notification:)), name: nameRegisterFailed, object: nil)
        
        // User email already exist
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterVC.registerListener(notification:)), name: nameAlreadyExistData, object: nil)
        
    }
    
    @objc func registerListener(notification: NSNotification) {
        
        switch notification.name {
        case nameRegsiterSuccess:
            // show success message and navigate to Login
            let alertController = UIAlertController(title: nil, message: "Registered Successfully, Login and enjoy the BitTicker", preferredStyle: UIAlertController.Style.alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                // dismiss and goback to login
                self.dismissRegisterVC()
            })
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            break
        case nameAlreadyExistData:
            alert(message: "User details already Exist, Try with other email")
            break
        case nameRegisterFailed:
            
            // register failed with some other reason
            alert(message: "Something went wrong, Try Again")
            break
        default:
            break
        }
    }
    
    // register delegates and listen
    func registerTFDelegate()  {
        
        tfName.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirmPassword.delegate = self
    }
    
    // setup Ui componets
    func setUpUiComponents()  {
        
        // SetUp Username Textfield
        tfName.label.text = "User Name"
        tfName.placeholder = "John"
        tfName.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfName.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfName.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfName.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfName.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfName.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfName.clearButtonMode = .always
        tfName.clearButtonMode = .whileEditing
        tfName.delegate = self
        
        // SetUp Email Textfield
        tfEmail.label.text = "Email"
        tfEmail.placeholder = "john@gmail.com"
        tfEmail.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfEmail.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfEmail.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfEmail.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfEmail.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfEmail.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfEmail.clearButtonMode = .always
        tfEmail.clearButtonMode = .whileEditing
        tfEmail.delegate = self
        
        // SetUp Password Textfield
        tfPassword.label.text = "Password"
        tfPassword.placeholder = "Any Password"
        tfPassword.autocorrectionType = .no
        tfPassword.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfPassword.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfPassword.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfPassword.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfPassword.clearButtonMode = .always
        tfPassword.clearButtonMode = .whileEditing
        tfPassword.delegate = self
        
        // SetUp Confirm Password Textfield
        tfConfirmPassword.label.text = "Confirm Password"
        tfConfirmPassword.placeholder = "Enter the same password"
        tfConfirmPassword.autocorrectionType = .no
        tfConfirmPassword.setOutlineColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfConfirmPassword.setOutlineColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfConfirmPassword.setTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfConfirmPassword.setTextColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .editing)
        tfConfirmPassword.setFloatingLabelColor(#colorLiteral(red: 0.02043063939, green: 0.517778635, blue: 0.5219944119, alpha: 1), for: .editing)
        tfConfirmPassword.setFloatingLabelColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        tfConfirmPassword.clearButtonMode = .always
        tfConfirmPassword.clearButtonMode = .whileEditing
        tfConfirmPassword.delegate = self
        
        // make logo rounded
//        ivLogo.makeRounded()
        
    }
    
    // submit button action
    @IBAction func onSubmitClick(_ sender: Any) {
        
        // validate user inputs and save data in local db
        validate()
    }
    
    // login button action
    @IBAction func onLoginClick(_ sender: Any) {
        
        // go back to login
        dismissRegisterVC()
    }
    
    // pop current vc
    func dismissRegisterVC()  {
        // Dismiss the regsiter VC
        self.dismiss(animated: false, completion: nil)
    }
    
    // validate user inputs
    func validate() {
        do {
            let username = try tfName.validatedText(validationType: ValidatorType.username)
            let email = try tfEmail.validatedText(validationType: ValidatorType.email)
            let password = try tfPassword.validatedText(validationType: ValidatorType.password)
            let confirmPass = try tfConfirmPassword.validatedText(validationType: ValidatorType.password)
            
            if password == confirmPass {
                // save data to DB
                saveData(email: email, userName: username, password: password)
            }
            else {
                alert(message: "Password Missmatch")
            }
            
        } catch(let error) {
            alert(message:(error as! ValidationError).message)
        }
    }
    
    // save user data to database
    func saveData(email: String, userName: String, password: String)  {
        
        // create user for login
        let user = LoginUser(userName: userName, email: email, password: password)
        
        // store in data
        PersistanceManager.shared.save(loginUser: user)
        
    }
    
}

// implement delegates
extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == tfName { 
            tfEmail.becomeFirstResponder()
        }
        else if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        }
        else if textField == tfPassword {
            tfConfirmPassword.becomeFirstResponder()
        }
        return true
    }
}
