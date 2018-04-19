//
//  OperatorsModel.swift
//  InSpectionPro
//
//  Created by praveen dole on 3/26/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation

class OperatorsModel: NSObject {
    
    //MARK: - Model's Constants
    private let kName                         =              "name"
   
    
    
    //MARK: - Properties
    
    var name                                 :              String = ""
  
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
            
        }
    }
    
    
}
