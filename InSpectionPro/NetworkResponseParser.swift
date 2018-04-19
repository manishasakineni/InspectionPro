//
//  NetworkResponseParser.swift
//  InSpectionPro
//
//  Created by Mac OS on 12/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class NetworkResponseParser: NSObject {

    static let sharedInstance = NetworkResponseParser()

    //MARK: - Prase Login Response
    
    func parseLoginResponse(_ object: AnyObject?) -> LoginModel {
        
        var loginModel = LoginModel()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                loginModel = LoginModel.init(dict: response)
            }
        }
        
        return loginModel
    }

    //MARK: - Prase Freight Terms
    func parseAllModel(object: AnyObject?) -> Array<AllModel> {
        
        var allModels = Array<AllModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            if let response = object as? NSDictionary {
                 let data = response["lines"]
                if Utilities.sharedInstance.isObjectNull(data as AnyObject) {
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for allModelsDetails in response {
                                if Utilities.sharedInstance.isObjectNull(allModelsDetails as AnyObject?) {
                                    if let category = allModelsDetails as? NSDictionary {
                                    let countAllModels = AllModel(dict: category)
                                
                                    allModels.append(countAllModels)
                                }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return allModels
    }
    
    
    //MARK: - Prase Freight Terms
    
    func parseDeficencyCorrectiveModel(object: AnyObject?) -> Array<DeficencyCorrectiveModel> {
        
        var deficencyCorrectiveModel = Array<DeficencyCorrectiveModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["values"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for deficencyCorrectiveModelsDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(deficencyCorrectiveModelsDetails as AnyObject?) {
                                    
                                    let countDeficencyCorrectiveModels = DeficencyCorrectiveModel(dict: deficencyCorrectiveModelsDetails as? NSDictionary)
                                    deficencyCorrectiveModel.append(countDeficencyCorrectiveModels)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return deficencyCorrectiveModel
    }
    
    //MARK: - Prase Freight Terms
    func parseOperationsModel(object: AnyObject?) -> Array<String> {
        
        var deficencyCorrectiveModel = Array<String>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            
            if let response = object as? NSDictionary {
                
                let data = response["operators"]
                
                if Utilities.sharedInstance.isObjectNull(data as AnyObject?) {
                    
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for deficencyCorrectiveModelsDetails in response {
                                
                                if Utilities.sharedInstance.isObjectNull(deficencyCorrectiveModelsDetails as AnyObject?) {
                                    
                            deficencyCorrectiveModel.append(deficencyCorrectiveModelsDetails as! String)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return deficencyCorrectiveModel
    }
    
    //MARK: - Prase Freight Terms
    func parseSubUnitModel(object: AnyObject?) -> Array<AllModel> {
        
        var allModels = Array<AllModel>()
        
        if Utilities.sharedInstance.isObjectNull(object) {
            if let response = object as? NSDictionary {
                let data = response["lines"]
                if Utilities.sharedInstance.isObjectNull(data as AnyObject) {
                    if let response = data as? NSArray {
                        if Utilities.sharedInstance.isObjectNull(response) {
                            
                            for allModelsDetails in response {
                                if Utilities.sharedInstance.isObjectNull(allModelsDetails as AnyObject?) {
                                    if let category = allModelsDetails as? NSDictionary {
                                       
                                        let blog = category["units"]
                                        if Utilities.sharedInstance.isObjectNull(blog as AnyObject) {
                                        if let responseblog = blog as? NSArray {
                                            if Utilities.sharedInstance.isObjectNull(responseblog) {
                                            print(responseblog)
                                                for blogAllModelsDetails in responseblog {
                                        if Utilities.sharedInstance.isObjectNull(blogAllModelsDetails as AnyObject?) {
                                            if let blogCategory = blogAllModelsDetails as? NSDictionary {
                                             
                                                let blogCountAllModels = AllModel(dict: blogCategory)
                                                allModels.append(blogCountAllModels)
                                                      }
                                                
                                                    }
                                                }
                                            }
                                          }
                                        }
           
                                    }
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        return allModels
    }

}
