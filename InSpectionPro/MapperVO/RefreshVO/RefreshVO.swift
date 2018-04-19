//
//  RefreshVO.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation


//{
//    "inspectionId": "a69ef893-fe13-4fe2-bd5c-7865d408a26d",
//    "result": true
//}

//{"lineId":"b4618311-1955-4b0d-8439-4f18d15d1174","transactionId":"null","failedUnits":[]}


class RefreshVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    

    var lineId : String?
    var transactionId : String?
    var failedUnits: String?
    

    
    //MARK:-  initialization of SignupVo
    
    init(lineId : String?,transactionId : String?,failedUnits: String?) {
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
