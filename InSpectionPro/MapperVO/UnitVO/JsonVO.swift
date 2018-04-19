//
//  JsonVo.swift
//  InSpectionPro
//
//  Created by praveen dole on 2/9/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import Foundation
class JsonVO: Mappable {
    
    
    //MARK:-  Declaration of SignupVo
    
    //  var result: RegisterVo?
    //  var isSuccess: Bool?
    
    var lines: [LinesVO]?
    
    //  var endUserMessage: String?
    //  var exception : Any?
    
    //MARK:-  initialization of SignupVo
    
    init(lines: [LinesVO]?) {
        self.lines = lines
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        lines <- map["lines"]
}
}
