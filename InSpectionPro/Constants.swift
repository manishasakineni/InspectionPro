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


//Base URLs
// MARK:- All API-Services
let BASE_TEST_SERVICE_URL = "http://vitest.cloudapp.net/api/ProApp/"
let BASE_SIGNIN_URL = BASE_TEST_SERVICE_URL + "Login"
let BASE_GETLINES_URL = BASE_TEST_SERVICE_URL + "GetLines"
let BASE_SAVELINES_URL = BASE_TEST_SERVICE_URL + "SaveLines"




//MARK: - User Default Constants

let kLoading = "Loading..."

let kAppTitle = "InSpectionPro"
let kSignInError = "Please enter valid credentials"

let kUserName = "userName"
let kPassword = "password"
let kHasLoggedIn = "hasLoggedIn"
let kEmail = "email"
let kIsFromMail = "isFromMail"

let kTokenType = "tokenType"
let kAccessToken = "accessToken"
let kTimeOutInterval = 60.0


let kRememberMe = "rememberMe"
let kIsFirstTime = "isFirstTime"

let kToastDuration  = 1.5
let klineId:String = "klineId"
let KnameLineId:String = "KnameLineId"
let KunitId:String = "KunitId"


let kFailedViewController = "FailedViewController"

struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    
}

let UI_ELEMENTS_COLOR = UIColor.init(red: 11.0/255.0, green: 4.0/255.0, blue: 146.0/255.0, alpha: 0.2)

