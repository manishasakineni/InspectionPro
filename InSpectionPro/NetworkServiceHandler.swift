//
//  NetworkServiceHandler.swift
//  InSpectionPro
//
//  Created by Mac OS on 11/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class NetworkServiceHandler: NSObject {

    static let sharedInstance = NetworkServiceHandler()

  //  let responseParser = NetworkResponseParser.sharedInstance
    var reachability: Reachability?
    var authorizationHeaderKey = "Authorization"
    
    //MARK: - AFNetworking Manager
    private func isConnectionEshtablished() -> Bool {
        
        reachability = Reachability.init()!
        let networkStatus: Int = reachability!.currentReachabilityStatus.hashValue
        setupReachability(hostName: "google.com", useClosures: true)
        return (networkStatus != 0)
    }
    
    func setupReachability(hostName: String?, useClosures: Bool) {
        
        let reachability = hostName == nil ? Reachability() : Reachability(hostname: hostName!)
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                DispatchQueue.main.async {
                    
                    print("Network is reachable")
                    // Reachable
                }
            }
            reachability?.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    
                    print("Network is not reachable")
                    // Non Reachable
                }
            }
        }
    }
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
        }
    }
    

    
    //MARK: - -----------------------------------------
    //MARK:   >>>>>>>>>>> USER LOGIN API <<<<<<<<<<<<
    //MARK:   -----------------------------------------
     //MARK: - User Login API
    
    // MARK:- POST Method

    func loginInWith(viewController: UIViewController,parameters: Dictionary<String,Any>, successBlock: @escaping (_ loginModel : LoginModel) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {

        if isConnectionEshtablished() {
            
            let request = NSMutableURLRequest(url: NSURL(string: BASE_SIGNIN_URL)! as URL)
            request.timeoutInterval = kTimeOutInterval
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

            do{
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
            }catch {
                print("parsing error")
            }
          
            let session = URLSession.shared
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    
                    
                    if let errorDescription = error?.localizedDescription {
                        
                        DispatchQueue.main.async {
                            failureBlock(true)
                         //   self.ShowError(viewController, message: errorDescription)
                            print("errorDescription", errorDescription)
                        }
                    }
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                // Checking here Response
                if response != nil {
                    
                 //   viewController.hideHUD()
                    
                    
                    do {
                        //create json object from data
                        
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                            DispatchQueue.main.async {
                                let loginModel = NetworkResponseParser.sharedInstance.parseLoginResponse(json)
                                   successBlock(loginModel)
//                                if loginModel.error != "" {
//
//                                    failureBlock(true)
//                                    self.ShowError(viewController, message: loginModel.errorDescription)
//
//                                } else {
//
//                                    successBlock(loginModel)
//                                }
                            }
                            print(json)
                        }
                        
                    } catch let catchError as NSError {
                        
                        DispatchQueue.main.async {
                            failureBlock(true)
                            print("invalid USERID & PASSWORD")

                  //          self.ShowError(viewController, message: catchError.localizedDescription)
                        }
                    }
                    
                    
                }else{
                    
                    
                    
                    if let errorDescription = error?.localizedDescription {
                        
                        DispatchQueue.main.async {
                            failureBlock(true)
                    //        print("invalid USERID & PASSWORD")
                        //    self.ShowError(viewController, message: errorDescription)
                        }
                    }
                }
                
            })
            
            task.resume()
            
            
           
        }

    
    }
    
    // MARK:- GET Method
    func getAllModels(_ viewController: UIViewController, successBlock: @escaping (_ lines: Array<AllModel>,_ values : Array<DeficencyCorrectiveModel>,_ operations: Array<String>,_ unit: Array<AllModel>) -> Void, failureBlock: @escaping (_ fail: Bool) -> Void) {
        
        if isConnectionEshtablished() {
            
            viewController.showHud(kLoading)

            
            do {
                
                // create post request
                let endpoint: String = BASE_GETLINES_URL
                
                let session = URLSession.shared
                
             //   let request = networkSharedInstance(endpoint)
                
                
                let request = NSMutableURLRequest(url: NSURL(string: endpoint)! as URL)
                
                request.timeoutInterval = kTimeOutInterval
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
             //   request.setValue(tokenType + " " + accessToken,forHTTPHeaderField: "Authorization")
                
                request.httpMethod = "GET"
                
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                   
                    
                    guard error == nil else {
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                 viewController.hideHUD()
                                failureBlock(true)
                             //   self.ShowError(viewController, message: errorDescription)
                            }
                        }
                        return
                    }
                    
                    
                    guard let data = data else {
                        return
                    }
                    
                    // Checking here Response
                    if response != nil {
                        
                    
                        
                        let statusCode = (response as! HTTPURLResponse).statusCode
                        
                        
                        do {
                            //create json object from data
                            
                            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary {
                                
                                
                            
                                
                                if 200...299 ~= statusCode {
                                    
                                    DispatchQueue.main.async {
                                            viewController.hideHUD()
                                        
                                        let frieghtTypes = NetworkResponseParser.sharedInstance.parseAllModel(object: json as AnyObject)
                                        
                                       
                                        
                                        
                                        
                                        
                                        let deficencyCorrectiveData = NetworkResponseParser.sharedInstance.parseDeficencyCorrectiveModel(object: json)
                                        
                                        let operationsData = NetworkResponseParser.sharedInstance.parseOperationsModel(object: json)
                                        
                                        let unitData = NetworkResponseParser.sharedInstance.parseSubUnitModel(object: json)

                                        successBlock(frieghtTypes ,deficencyCorrectiveData,operationsData,unitData)
                                    }
                                    
                                }else if 401 == statusCode {
                                    DispatchQueue.main.async {
                                            viewController.hideHUD()
                                   //     self.moveToHomeScreen(kUnauthorizedError)
                                    }
                                } else {
                                    
                                    
                                    if Utilities.sharedInstance.isObjectNull(json as AnyObject?) {
                                        
                                        if let statusMessage = json["message"] as? String{
                                            
                                            DispatchQueue.main.async {
                                                failureBlock(true)
                                                    viewController.hideHUD()
                                         //       self.ShowError(viewController, message: statusMessage)
                                            }
                                        }
                                    }
                                    
                                }
                                
                                print("Json", json)
                                
                            }
                            
                        } catch let catchError as NSError {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                    viewController.hideHUD()
                             //   self.ShowError(viewController, message: catchError.localizedDescription)
                            }
                        }
                        
                        
                    }else{
                        
                        
                        
                        if let errorDescription = error?.localizedDescription {
                            
                            DispatchQueue.main.async {
                                failureBlock(true)
                                    viewController.hideHUD()
                          //      self.ShowError(viewController, message: errorDescription)
                            }
                        }
                    }
                    
                    
                    
                    
                })
                task.resume()
            }
        }else {
            
       //     ShowError()
        }
    }
    
    // MARK :- OBJECTIE MAPPER
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
