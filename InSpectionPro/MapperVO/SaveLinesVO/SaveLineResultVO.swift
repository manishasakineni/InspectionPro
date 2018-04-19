//
//  SaveLineResultVO.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class SaveLineResultVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    //  var result: RegisterVo?
    //  var isSuccess: Bool?
    
    var inspectionId : String?
    var result : Bool?
    
    //  var endUserMessage: String?
    //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
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
