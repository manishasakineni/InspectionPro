//
//  StaticData.swift
//  InSpectionPro
//
//  Created by Mac OS on 29/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import Foundation

var APP_DELEGATE : AppDelegate = UIApplication.shared.delegate as! AppDelegate

//let NAVY_BLUE_COLOR = UIColor.init(colorLiteralRed: 7.0/255.0, green: 68.0/255.0, blue: 119.0/255.0, alpha: 1.0)

//MARK: - User Default Constants


let kAppTitle = "InSpectionPro"
let kSignInError = "Please enter valid credentials"

let kUserName = "userName"
let kPassword = "password"
let kHasLoggedIn = "hasLoggedIn"
let kEmail = "email"
let kIsFromMail = "isFromMail"

let kTokenType = "tokenType"
let kAccessToken = "accessToken"


let kRememberMe = "rememberMe"
let kIsFirstTime = "isFirstTime"



let kFailedViewController = "FailedViewController"

struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

let UI_ELEMENTS_COLOR = UIColor.init(red: 11.0/255.0, green: 4.0/255.0, blue: 146.0/255.0, alpha: 0.2)

