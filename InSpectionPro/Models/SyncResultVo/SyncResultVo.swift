//
//  SyncResultVo.swift
//  InSpectionPro
//
//  Created by praveen dole on 3/27/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class SyncResultVo: Mappable {
    
    var inspectionId : String?
    var result : Bool?
   
    
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(inspectionId : String?,result : Bool?) {
        
        
        self.inspectionId = inspectionId
        self.result = result
      
        
        
        
        
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        inspectionId <- map["inspectionId"]
        result <- map["result"]
       
    }
    
    
}

