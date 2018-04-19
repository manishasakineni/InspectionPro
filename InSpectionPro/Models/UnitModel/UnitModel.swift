//
//  UnitModel.swift
//  InSpectionPro
//
//  Created by Mac OS on 20/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class UnitModel: NSObject {
    
    //MARK: - Model's Constants
    private let kAppId                        =            "appId"
    private let kName                         =              "name"
    private let kUnitId                       =            "unitId"
    private let kLineId                       =            "lineId"

    
    //MARK: - Properties

    var name                                 :              String = ""

    var appId                                :              String = ""

    var unitId                               :              String = ""

    var lineId                               :              String = ""

    override init() {
        
    }
    
    init(dict: NSDictionary?) {
       
        
        super.init()
        if dict != nil {

            
            
            //name
            if Utilities.sharedInstance.isObjectNull("\(dict![kName])" as AnyObject?) {
                
                if let nameString = dict![kName] as? String {
                    
                    name = (nameString.characters.count) > 0 ? nameString : ""
                }
            }
            if Utilities.sharedInstance.isObjectNull("\(dict![kAppId])" as AnyObject?) {
                
                if let appIdString = dict![kAppId] as? String {
                    
                    appId = (appIdString.characters.count) > 0 ? appIdString : ""
                }
            }
            if Utilities.sharedInstance.isObjectNull("\(dict![kLineId])" as AnyObject?) {
                
                if let lineIdString = dict![kLineId] as? String {
                    
                    lineId = (lineIdString.characters.count) > 0 ? lineIdString : ""
                }
            }
            if Utilities.sharedInstance.isObjectNull("\(dict![kUnitId])" as AnyObject?) {
                
                if let unitIdString = dict![kUnitId] as? String {
                    
                    unitId = (unitIdString.characters.count) > 0 ? unitIdString : ""
                }
            }
            
        }
    }
    
    
}
