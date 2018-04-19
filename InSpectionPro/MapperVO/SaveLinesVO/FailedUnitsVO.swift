//
//  FailedUnitsVO.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/12/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class FailedUnitsVO: Mappable {
    
    var deficiency : [String]?
    var correction : [String]?
    var unitId : String?
    var person : String?
    var comments : String?
    
    
    //MARK:-  initialization of VideosVO
    
    
    init(deficiency : [String]?, correction : [String]?,unitId : String?, person : String?,comments : String?) {
        
        self.deficiency = deficiency
        self.correction = correction
        self.unitId = unitId
        self.person = person
        self.comments = comments
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        deficiency <- map["deficiency"]
        correction <- map["correction"]
        unitId <- map["unitId"]
        person <- map["person"]
        comments <- map["comments"]
    }
    
}
