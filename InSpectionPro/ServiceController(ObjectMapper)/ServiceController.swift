//
//  ServiceController.swift
//  Telugu Churches
//
//  Created by N@n!'$ Mac on 19/01/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
import SVProgressHUD
import SystemConfiguration

let reachability = Reachability()!
var appDelegate = AppDelegate()

let content_type = "application/json; charset=utf-8"

class ServiceController: NSObject {
    
    
    
    
    func postURLRequest(_ViewController :UIViewController,strURL:NSString,postParams:NSDictionary,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
     //   if appDelegate.checkInternetConnectivity() == false {
     //       UIApplication.shared.isNetworkActivityIndicatorVisible = false
     //       appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
      //      return
     //   }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true

    //    MBProgressHUD.hide(for:appDelegate.window,animated:true)
      //  MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding.utf8.rawValue)! as NSString
        let url: NSURL = NSURL(string: urlStr as String)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        request.httpMethod = "PUT"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        request.addValue("application/json",forHTTPHeaderField:"Accept")
        
        if postHeaders["Authorization"] != nil  {
            //            request.addValue(postHeaders[kCustomer_id] as! String, forHTTPHeaderField: kCustomer_id)
            //            request.addValue(postHeaders[tokenType + " " + accessToken] as! String, forHTTPHeaderField: "Authorization")
            
            //            request.setValue(tokenType + " " + accessToken,forHTTPHeaderField: "Authorization")
            
        }
        
//        let defaults = UserDefaults.standard
//        
//        if let authToken = defaults.string(forKey: accessToken) {
//            
//            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
//            
//        }
        
        do {
            let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            
            let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
            let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
            
            print("Request Url :\(url)")
            print("Request Header Data :\(headerDataString)")
            print("Request Data : \(dataString)")
            
            request.httpBody = data
            // do other stuff on success
            
        }
        catch {
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                SVProgressHUD.show(withStatus: "Looding...")

                print("JSON serialization failed:  \(error)")
               // appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            
            //            print(data)
            //            print(response)
            //            print(error)
            
            DispatchQueue.main.async(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
              //  SVProgressHUD.hide(for: appDelegate.window, animated: true)
                
                if response != nil {
                    
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 401 {
                        
                        failureHandler("unAuthorized")
                        
                        //                    failure("unAuthorized")
                        
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                        //                        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                        //                        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier!)
                        //
                        //                            })
                        //                     let expireTokenTime:String = UserDefaults.standard.value(forKey: expiresIn) as! String
                        //
                        //                            if let expiresInSeconds = Int(expireTokenTime) {
                        //
                        //                                timer.invalidate()
                        //
                        //                                timer = Timer.scheduledTimer(timeInterval: TimeInterval(expiresInSeconds), target: self, selector: #selector(self.refreshTokenForLogin), userInfo: nil, repeats: false)
                        //
                        //                                    guard isManualLogin else { return }
                        //
                        //                    }
                        //
                        //                                    isManualLogin = false
                        
                    }
                    else if error != nil
                    {
                        print("error=\(String(describing: error))")
                     //   appDelegate.window?.makeToast(kRequestTimedOutMessage, duration:kToastDuration , position:CSToastPositionCenter)
                        return
                        
                    } else{
                        do {
                            let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
                            print(parsedData)
                            successHandler(parsedData as AnyObject)
                            
                        } catch let error as NSError {
                            
                            print("error=\(error)")
                            //                    appDelegate.window?.makeToast((error.localizedDescription) as String, duration:kToastDuration , position:CSToastPositionCenter)
                            
                            //                     appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
                            return
                        }
                    }
                    
                }
                
            }
        }
        task.resume()
        
    }

    
    

    
    
  
    func getURLRequest(strURL:String,success:@escaping(_ _result:AnyObject)->Void,failure:@escaping(_ error:String) -> Void) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        if appDelegate.checkInternetConnectivity() == false
//        {
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            appDelegate.window?.makeToast(kNetworkStatusMessage, duration: kToastDuration, position: CSToastPositionBottom)
//            return
//        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        MBProgressHUD.hide(for:appDelegate.window,animated:true)
//        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
        
        let request = NSMutableURLRequest(url: NSURL(string: strURL)! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "GET"
        
//        let defaults = UserDefaults.standard
//        
//        if let authToken = defaults.string(forKey: accessToken) {
//            
//            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
//            
//        }
        
        
        let task = URLSession.shared.dataTask(with:request as URLRequest){(data,response,error) in
            DispatchQueue.main.async(){
           //     MBProgressHUD.hide(for:appDelegate.window,animated:true)
                
                print(response)
                
                if response != nil {
                    
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 401 {
                        
                        print("failuer 1")

                        failure("unAuthorized")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    if statusCode == 500 {
                        
                        print("failuer 1")
                        
                        failure("unAuthorized")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    if statusCode == 404 {
                        
                        print("failuer 1")
                        
                        failure("Enter Valid Credentials")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    else if error != nil
                    {
                        
                        
                        print("failuer 1")

                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                                          //  failure(error! as NSError)
                        
                      //  appDelegate.window?.makeToast(error?.localizedDescription, duration:kToastDuration , position:CSToastPositionCenter)
                        
                    }
                        
                    else
                    {
                        print(statusCode)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        do{
                            print("success 1")

                            let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as![String:Any]
                            print(parsedData)
                            success(parsedData as AnyObject)
                        }
                        catch{
                            print("error=\(error)")
                            //                        appDelegate.window?.makeToast(error.localizedDescription, duration:kToastDuration , position:CSToastPositionCenter)
                            
                            //                        appDelegate.window?.makeToast("Your session has been timed out. Please login again", duration:kToastDuration , position:CSToastPositionCenter)
                            
                            
                            return
                        }
                        
                    }
                }
                
            }
        }
        task.resume()
}
 
    // MARK :- Mapper Post Method
    func postRequest(_viewController :UIViewController,strURL:NSString,postParams:NSDictionary,postHeaders:NSDictionary,successHandler:@escaping(_ _result:Any)->Void,failureHandler:@escaping (_ error:String)->Void) -> Void {
        
        if (appDelegate.checkInternetConnectivity()) {
            
         //   _viewController.showHud(kLoading)
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if appDelegate.checkInternetConnectivity() == false {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
       //     appDelegate.window?.makeToast(kNetworkStatusMessage,duration:kToastDuration,position:CSToastPositionBottom)
            return
        }
     //   MBProgressHUD.hide(for:appDelegate.window,animated:true)
     //   MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
        let urlStr:NSString = strURL.addingPercentEscapes(using:String.Encoding.utf8.rawValue)! as NSString
        let url: NSURL = NSURL(string: urlStr as String)!
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        request.httpMethod = "Put"
        request.addValue("application/json",forHTTPHeaderField:"Content-Type")
        request.addValue("application/json",forHTTPHeaderField:"Accept")
        
        if postHeaders["Authorization"] != nil  {
            //            request.addValue(postHeaders[kCustomer_id] as! String, forHTTPHeaderField: kCustomer_id)
            //            request.addValue(postHeaders[tokenType + " " + accessToken] as! String, forHTTPHeaderField: "Authorization")
            
            //            request.setValue(tokenType + " " + accessToken,forHTTPHeaderField: "Authorization")
            
        }
        
        //        let defaults = UserDefaults.standard
        //
        //        if let authToken = defaults.string(forKey: accessToken) {
        //
        //            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
        //
        //        }
        
        do {
            let data = try! JSONSerialization.data(withJSONObject:postParams, options:.prettyPrinted)
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            
            let headerData = try! JSONSerialization.data(withJSONObject:postHeaders, options:.prettyPrinted)
            let headerDataString = String(data: headerData, encoding: String.Encoding.utf8)!
            
            print("Request Url :\(url)")
            print("Request Header Data :\(headerDataString)")
            print("Request Data : \(dataString)")
            
            request.httpBody = data
            

            // do other stuff on success
            
        }
        catch {
            DispatchQueue.main.async(){
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //    MBProgressHUD.hide(for: appDelegate.window, animated: true)
                print("JSON serialization failed:  \(error)")
                appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
            }
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(data, response, error) in
            //_viewController.hideHUD()
            //            print(data)
            //            print(response)
            //            print(error)
            
            DispatchQueue.main.async(){
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
        //        MBProgressHUD.hide(for: appDelegate.window, animated: true)
                
                if response != nil {
                //    _viewController.hideHUD()
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 401 {
                        
                        failureHandler("unAuthorized")
                        
                        //                    failure("unAuthorized")
                        
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                        //                        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
                        //                        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier!)
                        //
                        //                            })
                        //                     let expireTokenTime:String = UserDefaults.standard.value(forKey: expiresIn) as! String
                        //
                        //                            if let expiresInSeconds = Int(expireTokenTime) {
                        //
                        //                                timer.invalidate()
                        //
                        //                                timer = Timer.scheduledTimer(timeInterval: TimeInterval(expiresInSeconds), target: self, selector: #selector(self.refreshTokenForLogin), userInfo: nil, repeats: false)
                        //
                        //                                    guard isManualLogin else { return }
                        //
                        //                    }
                        //
                        //                                    isManualLogin = false
                        
                    }
                    
                    if statusCode == 500 {
                        
                        print("failuer 1")
                        
                        failureHandler("unAuthorized")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                        
                    else if error != nil
                    {
                        print("error=\(String(describing: error))")
                //        appDelegate.window?.makeToast(kRequestTimedOutMessage, duration:kToastDuration , position:CSToastPositionCenter)
                        return
                        
                    } else{
                        do {
                            let parsedData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! [String:Any]
                            print(parsedData)
                            successHandler(parsedData as AnyObject)
                            
                        } catch let error as NSError {
                            
                            print("error=\(error)")
                            //                    appDelegate.window?.makeToast((error.localizedDescription) as String, duration:kToastDuration , position:CSToastPositionCenter)
                            
                            //                     appDelegate.window?.makeToast("Network is either slow or not Connected", duration:kToastDuration , position:CSToastPositionCenter)
                            return
                        }
                    }
                    
                }
                
            }
        }
        task.resume()
        }else{
            
        }
    }
    
    
    func getRequest(strURL:String,success:@escaping(_ _result:AnyObject)->Void,failure:@escaping(_ error:String) -> Void) {
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        if appDelegate.checkInternetConnectivity() == false
        //        {
        //            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //            appDelegate.window?.makeToast(kNetworkStatusMessage, duration: kToastDuration, position: CSToastPositionBottom)
        //            return
        //        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //        MBProgressHUD.hide(for:appDelegate.window,animated:true)
        //        MBProgressHUD.showAdded(to:appDelegate.window,animated:true)
        
        
        let request = NSMutableURLRequest(url: NSURL(string: strURL)! as URL)
        request.addValue(content_type, forHTTPHeaderField: "Content-Type")
        request.addValue(content_type, forHTTPHeaderField: "Accept")
        //// request.setValue(api_key, forHTTPHeaderField: "api_key")
        //        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        //        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.httpMethod = "GET"
        
        //        let defaults = UserDefaults.standard
        //        
        //        if let authToken = defaults.string(forKey: accessToken) {
        //            
        //            request.setValue("Bearer" + " " + authToken,forHTTPHeaderField: "Authorization")
        //            
        //        }
        
        
        let task = URLSession.shared.dataTask(with:request as URLRequest){(data,response,error) in
            DispatchQueue.main.async(){
                //     MBProgressHUD.hide(for:appDelegate.window,animated:true)
                
                print(response)
                
                if response != nil {
                    
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    print("statusCode:\(statusCode)")
                    
                    if statusCode == 401 {
                        
                        print("failuer 1")
                        
                        failure("unAuthorized")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    if statusCode == 500 {
                        
                        print("failuer 1")
                        
                        failure("unAuthorized")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    if statusCode == 404 {
                        
                        print("failuer 1")
                        
                        failure("Enter Valid Credentials")
                        //self.refreshTokenForLogin()
                        
                        //                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        //
                        //                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        //                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        //                    appDelegate.window?.rootViewController = viewController
                        
                    }
                    else if error != nil
                    {
                        
                        
                        print("failuer 1")
                        
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        //  failure(error! as NSError)
                        
                        appDelegate.window?.makeToast(error?.localizedDescription, duration:kToastDuration , position:CSToastPositionCenter)
                        
                    }
                        
                    else
                    {
                        print(statusCode)
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                        do{
                            print("success 1")
                            
                            let parsedData = try JSONSerialization.jsonObject(with:data!,options:.mutableContainers) as![String:Any]
                            print(parsedData)
                            success(parsedData as AnyObject)
                        }
                        catch{
                            print("error=\(error)")
                            //                        appDelegate.window?.makeToast(error.localizedDescription, duration:kToastDuration , position:CSToastPositionCenter)
                            
                            //                        appDelegate.window?.makeToast("Your session has been timed out. Please login again", duration:kToastDuration , position:CSToastPositionCenter)
                            
                            
                            return
                        }
                        
                    }
                }
                
            }
        }
        task.resume()
    }

    

}

