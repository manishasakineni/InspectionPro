//
//  DeficencyCorrectiveModel.swift
//  InSpectionPro
//
//  Created by Mac OS on 19/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class DeficencyCorrectiveModel: NSObject {
    
    
    //MARK: - Model's Constants
    private let kAppId                      =            "appId"
    private let kId                         =            "id"
    private let kParentId                   =            "parentId"
    private let kIsInspection               =            "isInspection"
    private let kName                       =            "name"
    
    
    //MARK: - Properties
    
    var appId                              :              String = ""
    var id                                 :              String = ""
    var parentId                           :              String = ""
    var isInspection                       :              Int? = nil
    var name                               :              String = ""
    
    //MARK: - Initialisation
    
    override init() {
        
    }
    
    init(dict: NSDictionary?) {
        
        super.init()
        if dict != nil {

            
            //appId
            if Utilities.sharedInstance.isObjectNull("\(dict![kAppId])" as AnyObject?) {
                
                if let appIdString = dict![kAppId] as? String {
                    
                    appId = (appIdString.characters.count) > 0 ? appIdString : ""
                }
            }
            
            //id
            if Utilities.sharedInstance.isObjectNull("\(dict![kId])" as AnyObject?) {
                
                if let idString = dict![kId] as? String {
                    
                    id = (idString.characters.count) > 0 ? idString : ""
                }
            }
            
            //parentId
            if Utilities.sharedInstance.isObjectNull("\(dict![kParentId])" as AnyObject?) {
                
                if let parentIdString = dict![kParentId] as? String {
                    
                    parentId = (parentIdString.characters.count) > 0 ? parentIdString : ""
                }
            }
            
    
                  
            //isInspection
            if Utilities.sharedInstance.isObjectNull("\(dict![kIsInspection])" as AnyObject?) {
                
                if let statusNumber = dict![kIsInspection] as? Int{
                    
                    isInspection = statusNumber
                    
                }
                
            }
            
            
            
            //name
            if Utilities.sharedInstance.isObjectNull("\(dict![kName])" as AnyObject?) {
                
                if let nameString = dict![kName] as? String {
                    
                    name = (nameString.characters.count) > 0 ? nameString : ""
                }
            }
        }
        
    }
    

}
