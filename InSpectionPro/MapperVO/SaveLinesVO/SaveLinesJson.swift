//
//  SaveLinesJson.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class SaveLinesJson: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    //  var result: RegisterVo?
    //  var isSuccess: Bool?
    
    var lineId : String?
    var transactionId : String?
    var failedUnits: [FailedUnitsVO]?

    //  var endUserMessage: String?
    //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(lineId : String?,transactionId : String?,failedUnits: [FailedUnitsVO]?) {
        self.lineId = lineId
        self.transactionId = transactionId
        self.failedUnits = failedUnits

        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lineId <- map["lineId"]
        transactionId <- map["transactionId"]
        failedUnits <- map["failedUnits"]

    }
}
