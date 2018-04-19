//
//  LoginModel.swift
//  InSpectionPro
//
//  Created by Mac OS on 12/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class LoginModel: NSObject {

    
    //MARK: - Model's Constants
    private let kUserName          =            "UserName"
    private let kPassWord          =            "Password"
    private let kRememberMe        =            "RememberMe"
    private let kApplicationName   =            "ApplicationName"
    private let kUser = "User"

    //MARK: - Properties
    
    var userName                   :            String = ""
    var password                   :            String = ""
    var rememberMe                 :            Bool = false
    var applicationName            :            String = ""
    var user                       :            String = ""
    
    //MARK: - Initialisation
    
    override init() {
        
    }
    
    init(dict: NSDictionary?) {

        super.init()
        
        if dict != nil {
        
            //userName
            if Utilities.sharedInstance.isObjectNull("\(dict![kUserName])" as AnyObject?) {
                
                if let userNameString = dict![kUserName] as? String {
                    
                    userName = (userNameString.characters.count) > 0 ? userNameString : ""
                }
            }
            
            
            //password
            if Utilities.sharedInstance.isObjectNull("\(dict![kPassWord])" as AnyObject?) {
                
                if let passwordString = dict![kPassWord] as? String {
                    
                    password = (passwordString.characters.count) > 0 ? passwordString : ""
                }
            }
            
            //rememberMe
            if Utilities.sharedInstance.isObjectNull("\(dict![kRememberMe])" as AnyObject?) {
                
                if let rememberMeBool = dict![kRememberMe] as? Bool {
                    
                    rememberMe =  rememberMeBool
                }   else  if let rememberMeBool = dict![kRememberMe] as? Int {
                    
                    rememberMe =  (rememberMeBool == 0) ? false : true
                }
            }
            
            //applicationName
            if Utilities.sharedInstance.isObjectNull("\(dict![kApplicationName])" as AnyObject?) {
                
                if let applicationNameString = dict![kApplicationName] as? String {
                    
                    applicationName = (applicationNameString.characters.count) > 0 ? applicationNameString : ""
                }
           }
            
            //user
            if Utilities.sharedInstance.isObjectNull("\(dict![kUser])" as AnyObject?) {
                
                if let userString = dict![kUser] as? String {
                    
                    user = (userString.characters.count) > 0 ? userString : ""
                }
            }
        }
      
    }
    
    
    
    
}
