//
//  LoginViewController.swift
//  InSpectionPro
//
//  Created by Mac OS on 11/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    var loginTitle = ["UISER ID","PASSWORD"]
    

    @IBOutlet weak var loginTableView: UITableView!
    
    var userName            : String = ""
    var password            : String = ""
    var isRemeberMe         : Bool = false
    var isManualLogin       : Bool = false
    var isFirstTime = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTableView.delegate = self
        loginTableView.dataSource = self
        
        let defaults: UserDefaults? = UserDefaults.standard
     
// MARK:- RememberMe UIButton Check And UnCheck Condition
          if let rememberMe = UserDefaults.standard.value(forKey: "rememberMe"){
             if(rememberMe as? String == "true"){
                userName = UserDefaults.standard.value(forKey: "SavedUserName") as! String
                password = UserDefaults.standard.value(forKey: "SavedPassword") as! String
                isRemeberMe = true
            }
        }

      registerTableViewCells()
        
        // Do any additional setup after loading the view.
    }
    
// MARK:- RememberMe UIButton Check And UnCheck Condition
    private func registerTableViewCells() {
        
        loginTableView.register(UINib.init(nibName: "LoginCell", bundle: nil), forCellReuseIdentifier: "LoginCell")
        loginTableView.register(UINib.init(nibName: "SignInCell", bundle: nil), forCellReuseIdentifier: "SignInCell")
        loginTableView.register(UINib.init(nibName: "ForgetPasswordCell", bundle: nil),
                                forCellReuseIdentifier: "ForgetPasswordCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

    //    self.navigationController?.navigationBar.isHidden = true

    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

    }
    // MARk:- Validation For Login Credentials
    private func validateSignIn() -> Bool {
        
        if (userName.characters.count > 0 && password.characters.count > 0) {
            
            return true
        }
        
        Utilities.sharedInstance.alertWithOkButtonAction(vc: self, alertTitle: kAppTitle, messege: kSignInError, clickAction: {

        })
        
        return false
    }
    // MARk:- POST API-Service For Login Credentials
    @objc private func callWebServiesForLogin() {

        if validateSignIn() {
            

            userName = userName.replacingOccurrences(of: " ", with: "")
            password = password.replacingOccurrences(of: " ", with: "")
            
            
            var httpDict = Dictionary<String,Any>()
            httpDict.updateValue(userName, forKey: "UserName")
            httpDict.updateValue(password, forKey: "Password")
            httpDict.updateValue(isRemeberMe, forKey: "RememberMe")
            print("userName",userName)
            if(appDelegate.checkInternetConnectivity()){

            NetworkServiceHandler.sharedInstance.loginInWith(viewController: self,parameters: httpDict, successBlock: { (loginModel) in
            
            var isEmail = false
            if self.userName.isValidEmailAddress()
            {
                isEmail = true
            }

            self.isManualLogin = false
    
            
            UserDefaults.standard.setValue("true", forKey: kIsFirstTime)
            UserDefaults.standard.synchronize()
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "rootNav") as! CCKFNavDrawer
                
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = viewController

        }, failureBlock: { (fail) in
            
        })
           

            }else{
            
                self.appDelegate.window?.makeToast("Please check your internet Connection...", duration:kToastDuration, position:CSToastPositionCenter)

            }

        }
    }
    
// MARK:- UITableviewDelegate AND UITableviewDataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (indexPath.row == 0) {
            
            let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
            loginCell.credentialTextField.delegate = self
            loginCell.credentialTextField.isSecureTextEntry = false
            loginCell.credentialTitle.text = loginTitle[indexPath.row]
            loginCell.credentialTextField.placeholder = "E-mail/Customer No#"
            loginCell.credentialTextField.tag = 4444 + indexPath.row
            loginCell.credentialTextField.text = userName
          
            return loginCell
            
        } else if (indexPath.row == 1) {
            
            let loginCell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! LoginCell
            loginCell.credentialTextField.delegate = self
            loginCell.credentialTextField.isSecureTextEntry = true
            loginCell.credentialTitle.text = loginTitle[indexPath.row]
           loginCell.credentialTextField.placeholder = "Password"
            loginCell.credentialTextField.tag = 4444 + indexPath.row
            loginCell.credentialTextField.text = password


            return loginCell
            
        } else if (indexPath.row == 2) {
            
            let signInCell = tableView.dequeueReusableCell(withIdentifier: "SignInCell", for: indexPath) as! SignInCell
            signInCell.signInButton.addTarget(self,
                                              action: #selector(LoginViewController.signInButtonTapped(_:)),
                                              for: UIControlEvents.touchUpInside)
            return signInCell
            
        } else {
            
            let forgotPasswordCell = tableView.dequeueReusableCell(withIdentifier: "ForgetPasswordCell",
                                                                   for: indexPath) as! ForgetPasswordCell
            forgotPasswordCell.rememberMeButton.setImage(isRemeberMe == true ? #imageLiteral(resourceName: "CheckBox_Selected") : #imageLiteral(resourceName: "blue-checkbox-30"), for: .normal)
            forgotPasswordCell.rememberMeButton.addTarget(self,
                                                          action: #selector(LoginViewController.rememberMeButtonTapped(_:)),
                                                          for: UIControlEvents.touchUpInside)
            
            return forgotPasswordCell
        }
    }
    //MARK: - UITable View Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        loginTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let loginCell : LoginCell = textField.superview?.superview as? LoginCell {
            
            if textField.text != "" {
                
                if textField.tag == 4444 {
                    
                    userName = textField.text!
                    
                } else {
                    
                    password = textField.text!
                }
                
            } else {
                
                if textField.tag == 4444 {
                    
                    userName = ""
                    
                } else {
                    
                    password = ""
                }
            }
        }
    }
 
// MARK:- UITextFieldDelegate Methods
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let disableEmojis = textField.disableEmojis() {
            
            return disableEmojis
        }
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (textField.tag == 4444) {
            
            userName = newString as String
            
            
        } else {
            
            password = newString as String
            print("password  \(password)")
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    @IBAction func signInButtonTapped(_ sender: UIButton) {
      
        loginTableView.endEditing(true)
        let defaults: UserDefaults? = UserDefaults.standard

        if isRemeberMe == true {
            defaults?.set( userName, forKey: "SavedUserName")
            defaults?.set( password, forKey: "SavedPassword")
            defaults?.set( "true", forKey: "rememberMe")
            UserDefaults.standard.synchronize()

        }else{
            defaults?.set( "", forKey: "SavedUserName")
            defaults?.set( "", forKey: "SavedPassword")
            defaults?.set( "false", forKey: "rememberMe")
            UserDefaults.standard.synchronize()

        }
        if let textField = view.viewWithTag(4444) as? UITextField {

            textField.resignFirstResponder()
        }
        isManualLogin = true
        callWebServiesForLogin()
        
        loginTableView.reloadData()
    }
    
    @IBAction func rememberMeButtonTapped(_ sender: UIButton) {
       isRemeberMe = !isRemeberMe
        loginTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
