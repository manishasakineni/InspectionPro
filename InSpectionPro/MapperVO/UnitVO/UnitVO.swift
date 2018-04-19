//
//  UnitVO.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/9/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class UnitVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    
    var appId : String?
    var name : String?
    var unitId : String?
    var lineId : String?

    
    
    //MARK:-  initialization of VideosVO
    
    
    init(appId : String?, name : String?,unitId : String?,lineId : String?) {
        
        self.appId = appId
        self.name = name
        self.unitId = unitId
        self.lineId = lineId

       
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        appId <- map["appId"]
        name <- map["name"]
        unitId <- map["unitId"]
        lineId <- map["lineId"]

    }
    
    
}
