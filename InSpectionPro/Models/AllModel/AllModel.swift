//
//  AllModel.swift
//  InSpectionPro
//
//  Created by Mac OS on 13/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class AllModel: NSObject {

    
    //MARK: - Model's Constants
    private let kAppId                  =            "appId"
    private let kLineId                 =            "lineId"
    private let kName                   =            "name"
    private let kFrequency              =            "frequency"
    private let kWindow                 =            "window"
    private let kLastExecuted           =            "lastExecuted"
    private let kClosed                 =            "closed"
    private let kStatus                 =            "status"
    private let kUnitId                 =            "unitId"

    
    private let kType                   =            "type"
    
    private let kUnits = "units"
    
    
 

    //MARK: - Properties
   
    var appId                          :            String = ""
    var lineId                         :            String = ""
    var name                           :            String = ""
    var frequency                      :            String = ""
    var window                         :            Int = 0
    var lastExecuted                   :            String = ""
    var closed                         :            Bool = true
 //   var status                       :            Bool = true
    var status                         :            Int = 0
    var unitId                           :            String = ""

    var type                           :            String = ""
    
     var isFailed : Bool  = true
     var isUnsaved : Bool  = true
     var isUpdatedServer : Bool  = true
    var isFailedSelected : Bool = false
    var isPassSelected : Bool = false




    var unitsArray = Array<UnitModel>()


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
            
            //lineId
            if Utilities.sharedInstance.isObjectNull("\(dict![kLineId])" as AnyObject?) {
                
                if let lineIdString = dict![kLineId] as? String {
                    
                    lineId = (lineIdString.characters.count) > 0 ? lineIdString : ""
                }
            }
            
            //name
            if Utilities.sharedInstance.isObjectNull("\(dict![kName])" as AnyObject?) {
                
                if let nameString = dict![kName] as? String {
                    
                    name = (nameString.characters.count) > 0 ? nameString : ""
                }
            }
            
            //frequency
            if Utilities.sharedInstance.isObjectNull("\(dict![kFrequency])" as AnyObject?) {
                
                if let frequencyString = dict![kFrequency] as? String {
                    
                    frequency = (frequencyString.characters.count) > 0 ? frequencyString : ""
                }
            }
            
            //window

            if Utilities.sharedInstance.isObjectNull("\(dict![kWindow])" as AnyObject?) {
                
                if let windowNumber = dict![kWindow] as? Int{
                    
                    
                    window = windowNumber
                    
                }
                
            }
            //lastExecuted
            if Utilities.sharedInstance.isObjectNull("\(dict![kLastExecuted])" as AnyObject?) {
                
                if let lastExecutedString = dict![kLastExecuted] as? String {
                    
                    lastExecuted = (lastExecutedString.characters.count) > 0 ? lastExecutedString : ""
                }
            }
            
           
            //closed
            if Utilities.sharedInstance.isObjectNull("\(dict![kClosed])" as AnyObject?) {
                
                if let closedBool = dict![kClosed] as? Bool {
                    
                    closed =  closedBool
                }   else  if let closedBool = dict![kClosed] as? Int {
                    
                    closed =  (closedBool == 0) ? false : true
                }
            }
            
            //status
            
            if Utilities.sharedInstance.isObjectNull("\(dict![kStatus])" as AnyObject?) {
                
                if let statusNumber = dict![kStatus] as? Int{
                    
                    
                    status = statusNumber
                    
                }
                
            }
            
            
            //unitId
            if Utilities.sharedInstance.isObjectNull("\(dict![kUnitId])" as AnyObject?) {
                
                if let unitIdString = dict![kUnitId] as? String {
                    
                    unitId = (unitIdString.characters.count) > 0 ? unitIdString : ""
                }
            }
            if Utilities.sharedInstance.isObjectNull("\(dict![kUnits])" as AnyObject?) {
                
                unitsArray.removeAll()
                
                
                if let response = dict![kUnits] as? NSArray {
                    
                    if Utilities.sharedInstance.isObjectNull(response) {
                        
                        for listOrderItemDetail in response {
                            
                            if Utilities.sharedInstance.isObjectNull(listOrderItemDetail as AnyObject?) {
                                
                                
                                let listOrderDetailsModel = UnitModel(dict: listOrderItemDetail as? NSDictionary)
                                unitsArray.append(listOrderDetailsModel)
                                
                                
                            }
                        }
                    }
                }
            }
                    type =  "0"
           
          
            
            
        
        
    }
    
    
}
}
