//
//  Utilities.swift
//  InSpectionPro
//
//  Created by Mac OS on 29/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import SVProgressHUD
class Utilities: NSObject {


    
    static let sharedInstance : Utilities = Utilities()

    //MARK: - Nil Check
    
    func isObjectNull(_ object: AnyObject?) -> Bool {
        return !isNil(object) && !isNull(object)
    }
    
    private func isNull(_ object: AnyObject?) -> Bool {
        if !isNil(object) {
            if object!.isKind(of: NSNull.self) || object?.classForCoder == NSNull.classForCoder() {
                return true
            } else {
                return isStringNull(object)
            }
        }
        return false
    }
    
    private func isNil(_ object: AnyObject?) -> Bool {
        return object == nil
    }
    
    private func isStringNull(_ object: AnyObject?) -> Bool {
        guard isNil(object) && isNull(object) else {
            let str = object as? String ?? ""
            return str == "<NULL>"
        }
        return false
    }
   
    class func getTokenType() -> String {
        
        let tokenType = UserDefaults.standard.value(forKey: kTokenType) as? String
        
        if tokenType == nil {
            
            return ""
            
        } else {
            
            return tokenType!
        }
    }
  
    //MARK: - Toast Methods
    
    class func showToast(_ view: UIView, text: String,position : String) {
        
        
        //let TOAST_BACKGROUND_COLOR = UIColor(Red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 0.8)

        var style = ToastStyle()
        style.backgroundColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 0.8)
        style.titleFont = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
        view.makeToast(text, duration: 2.0, position:CGPoint(x: ScreenSize.SCREEN_WIDTH/2, y: ScreenSize.SCREEN_HEIGHT - 360), style: style)
        
        UIApplication.shared.windows.last?.bringSubview(toFront: view)
    }
    
    
    
    class func setupHomeViewControllerNavBarColorInCntrWithColor(backImage: String,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, syncTotalRecodCount:String ,secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        titlelabel!.text = title
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = UIColor(red: 53.0/255.0, green: 53.0/255.0, blue: 53.0/255.0, alpha: 1.0)
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
//            cntr.navigationController?.navigationBar.barStyle = .black
        }
        if backImage != nil {
            let leftButtonImage: UIImage = UIImage(named: backImage)!
            let leftButton: UIButton = UIButton(type: .custom)
            //   leftButton.frame = CGRect(x: 15, y: 50, width: 300, height: 500)
            leftButton.isEnabled = true
            leftButton.isSelected = true
            leftButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            leftButton.setTitle(backTitle, for: .normal)
            if backTitle.characters.count > 0 {
            leftButton.setImage(leftButtonImage, for: .normal)
            }
            leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
            //   leftButton.addTarget(cntr, action: #selector(FailedViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
            let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
            cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        }
    

        
        if(secondRightImage != nil && thirdRightImage != nil){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: thirdRightImage), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(cntr, action: #selector(ViewController.logOutButtonTapped(_:)), for: .touchUpInside)
      //  btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: secondRightImage), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(cntr, action: #selector(ViewController.refreshButtonTapped(_:)), for: .touchUpInside)
 //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
            
            let btn3 = UIButton(type: .custom)
           // btn3.setImage(UIImage(named: secondRightImage), for: .normal)
            btn3.setTitle("\(syncTotalRecodCount)", for: .normal)
            btn3.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
          //  btn3.addTarget(cntr, action: #selector(ViewController.refreshButtonTapped(_:)), for: .touchUpInside)
            //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
            let item3 = UIBarButtonItem(customView: btn3)
            
        cntr.navigationItem.setRightBarButtonItems([item1,item2,item3], animated: true)
        }
        else{
            let btn1 = UIButton(type: .custom)
            btn1.setImage(UIImage(named: ""), for: .normal)
            btn1.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            btn1.addTarget(cntr, action: #selector(LogOutViewController.logOutButtonTapped(_:)), for: .touchUpInside)
            //  btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: btn1)
            let btn2 = UIButton(type: .custom)
            btn2.setImage(UIImage(named: ""), for: .normal)
            btn2.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            btn2.addTarget(cntr, action: #selector(LogOutViewController.refreshButtonTapped(_:)), for: .touchUpInside)
            //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
            let item2 = UIBarButtonItem(customView: btn2)
            let btn3 = UIButton(type: .custom)
            btn3.setImage(UIImage(named: secondRightImage), for: .normal)
            btn3.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
            btn3.addTarget(cntr, action: #selector(LogOutViewController.refreshButtonTapped(_:)), for: .touchUpInside)
            //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
            let item3 = UIBarButtonItem(customView: btn3)
            cntr.navigationItem.setRightBarButtonItems([item1,item2,item3], animated: true)
            
                //  if(secondRightImage == "" && thirdRightImage == ""){
                cntr.navigationItem.rightBarButtonItems = nil
                //    }
            }
    }
        
    class func setupFailedViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
    
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        titlelabel!.text = title
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = UIColor(red: 53.0/255.0, green: 53.0/255.0, blue: 53.0/255.0, alpha: 1.0)
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
      
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(FailedViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
    }
    class func setupAddMoreDeficienciesViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
        
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        
        titlelabel!.text = title
        
        if(cntr.navigationController != nil) {
            
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = UIColor(red: 53.0/255.0, green: 53.0/255.0, blue: 53.0/255.0, alpha: 1.0)
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        let leftButtonImage: UIImage = UIImage(named: backImage!)!
        let leftButton: UIButton = UIButton(type: .custom)
        
        leftButton.frame = CGRect(x: 0, y: 0, width: leftButtonImage.size.width, height: leftButtonImage.size.height)
        leftButton.setTitle(backTitle, for: .normal)
        if backTitle.characters.count > 0 {
            
            leftButton.setImage(leftButtonImage, for: .normal)
        }
        leftButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 12)
        leftButton.addTarget(cntr, action: #selector(AddMoreDeficienciesViewController.backLeftButtonTapped(_:)), for: .touchUpInside)
        let barbuttonitem1: UIBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        cntr.navigationItem.leftBarButtonItems = [barbuttonitem1]
        
    }
   
    class func setupLogOutViewControllerNavBarColorInCntrWithColor(backImage: String?,cntr: UIViewController,titleView: UIView?, withText title: String, backTitle:String, rightImage: String, secondRightImage:String, thirdRightImage : String) {
   
        var titlelabel: UILabel? = cntr.navigationController?.navigationBar.viewWithTag(555) as? UILabel
        
        if (titlelabel == nil) {
            
            titlelabel = UILabel(frame: CGRect(x: 50.0, y: 0, width: ScreenSize.SCREEN_WIDTH - 100, height: 44.0))
            titlelabel?.tag = 555
            titlelabel!.backgroundColor = UIColor.clear
            titlelabel!.font =  UIFont(name: "HelveticaNeue", size: 15.0)
            titlelabel?.textAlignment = .center
            titlelabel!.textColor = UIColor.white
            titlelabel?.lineBreakMode = .byWordWrapping
            titlelabel?.numberOfLines = 0
            
            cntr.navigationController?.navigationBar.addSubview(titlelabel!)
        }
        titlelabel!.text = title
        if(cntr.navigationController != nil) {
            cntr.navigationController!.navigationBar.isTranslucent = false
            cntr.navigationController!.isNavigationBarHidden = false
            cntr.navigationController!.navigationBar.barTintColor = UIColor(red: 53.0/255.0, green: 53.0/255.0, blue: 53.0/255.0, alpha: 1.0)
            cntr.navigationController!.navigationBar.tintColor = UIColor.white
            //            cntr.navigationController?.navigationBar.barStyle = .black
        }
        
        if(secondRightImage == nil && thirdRightImage == nil){
            let btn1 = UIButton(type: .custom)
            btn1.setImage(UIImage(named: thirdRightImage), for: .normal)
            btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn1.addTarget(cntr, action: #selector(LogOutViewController.logOutButtonTapped(_:)), for: .touchUpInside)
            
            //  btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: btn1)
            
            let btn2 = UIButton(type: .custom)
            btn2.setImage(UIImage(named: secondRightImage), for: .normal)
            btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn2.addTarget(cntr, action: #selector(LogOutViewController.refreshButtonTapped(_:)), for: .touchUpInside)
            //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
            let item2 = UIBarButtonItem(customView: btn2)
            
            cntr.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
        }
        else{
            let btn1 = UIButton(type: .custom)
            btn1.setImage(UIImage(named: ""), for: .normal)
            btn1.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            btn1.addTarget(cntr, action: #selector(LogOutViewController.logOutButtonTapped(_:)), for: .touchUpInside)
            
            //  btn1.addTarget(self, action: #selector(Class.Methodname), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: btn1)
            
            let btn2 = UIButton(type: .custom)
            btn2.setImage(UIImage(named: ""), for: .normal)
            btn2.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            btn2.addTarget(cntr, action: #selector(LogOutViewController.refreshButtonTapped(_:)), for: .touchUpInside)
            
            //       btn2.addTarget(self, action: #selector(Class.MethodName), for: .touchUpInside)
            let item2 = UIBarButtonItem(customView: btn2)
            
           // cntr.navigationItem.setRightBarButtonItems([item1,item2], animated: true)
            
            //  if(secondRightImage == "" && thirdRightImage == ""){
            cntr.navigationItem.rightBarButtonItems = nil
            //    }
        }
   
}
    //MARK: - User Defaults Methods
    
    //Save User Name and Password
    
    class func saveUserNameAndPassword(userName: String, password: String , email: String ,isFromEmail : Bool) {
     
        UserDefaults.standard.setValue(userName, forKey: kUserName)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.setValue(password, forKey: kPassword)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.setValue(email, forKey: kEmail)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.setValue(isFromEmail, forKey: kIsFromMail)
        UserDefaults.standard.synchronize()
        
        
        
        loggingIn(true)
        
     
    }
    
    //Custom Components Removed after app quit
    
    class func loggingIn(_ loginIn: Bool) {
        
        UserDefaults.standard.setValue(loginIn, forKey: kHasLoggedIn)
        UserDefaults.standard.synchronize()
    }
   
    
    //MARK:- UIAlert Controller Actions
    
    func alertWithOkButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  = messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "OK", style: .default) { _ in
            clickAction()
        }
        alrtControl.addAction(cancelButton)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
}
extension UITextField {
    
    func disableEmojis() -> Bool? {
        
        if self.isFirstResponder {
            
            if self.textInputMode?.primaryLanguage == "emoji" || self.textInputMode?.primaryLanguage == nil {
                
                return false
            }
        }
        
        
        return nil
}
    
    
    
}
//MARK: String Extensions

extension String {
    
    func isValidEmailAddress() -> Bool {
        
        do {
            
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
            
        } catch {
            
            return false
        }
    }
    //MARK:- UIAlert Controller Actions
    
    func alertWithOkButtonAction(vc :UIViewController, alertTitle:String, messege: String ,clickAction:@escaping () -> Void) {
        
        let capsMsg  = messege.capitalizingFirstLetter()
        let alrtControl = UIAlertController(title: alertTitle, message: capsMsg , preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: "OK", style: .default) { _ in
            clickAction()
            
        }
        alrtControl.addAction(cancelButton)
        vc.present(alrtControl, animated: true, completion: nil)
        
    }
    func capitalizingFirstLetter() -> String {
        
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    func allowCharactersAndSpacesOnly() -> String {
        
        let characterSet = CharacterSet.init(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ").inverted
        let trimmedString = self.components(separatedBy: characterSet).joined(separator: "")
        
        return trimmedString
    }
    
    func disableSpecialCharacters() -> Bool? {
        
        let ACCEPTABLE_CHARACTERS  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let characterSet = NSCharacterSet.init(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filteredString = self.components(separatedBy: characterSet).joined(separator: "")
        return filteredString == self
    }
    
    mutating func capitalizeFirstLetter() {
        
        self = self.capitalizingFirstLetter()
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    public func getAcronyms(separator: String = "") -> String
    {
        let acronyms = self.components(separatedBy: " ").map({ String($0.characters.first!) }).joined(separator: separator);
        return acronyms;
    }
    func SizeOf_String( font: UIFont) -> CGSize {
        let fontAttribute = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttribute)  // for Single Line
        return size;
    }
}


//MARK: - UIViewController Extesions

extension UIViewController {
    func showHud(_ message: String) {
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
}

