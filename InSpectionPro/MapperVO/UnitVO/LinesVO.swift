//
//  LinesVo.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/9/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class LinesVO: Mappable {
    
    //MARK:-  Declaration of VideosVO
    
    var appId : String?
    var closed : Int?
    var frequency : Int?
    var lastExecuted : String?
    var lineId : String?
    var name : String?
    var status : Int?
    var units : [UnitVO]?
   
    
    //MARK:-  initialization of VideosVO
    
    
    init(appId : String?, closed : Int?,frequency : Int?, lastExecuted : String?,lineId : String?,name : String?,status : Int?,units : [UnitVO]?) {
        
        self.appId = appId
        self.closed = closed
        self.frequency = frequency
        self.lastExecuted = lineId
        self.lineId = lineId
        self.name = name
        self.status = status
        self.units = units
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        appId <- map["appId"]
        closed <- map["closed"]
        frequency <- map["frequency"]
        lastExecuted <- map["lastExecuted"]
        lineId <- map["lineId"]
        name <- map["name"]
        status <- map["status"]
        units <- map["units"]
       
    }
    
    
}
