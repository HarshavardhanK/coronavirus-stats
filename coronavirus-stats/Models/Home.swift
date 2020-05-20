//
//  Home.swift
//  coronavirus-stats
//
//  Created by Harshavardhan K on 20/05/20.
//  Copyright © 2020 Harshavardhan K. All rights reserved.
//

import Foundation
import SwiftyJSON

class Case {
    
    var totalPositive: Int!
    var totalRecovered: Int!
    var totalDeceased: Int!
    
    var deltaPositive: Int!
    var deltaRecovered: Int!
    var deltaDeceased: Int!
    
    init(data: JSON) {
        totalPositive = data["confirmed"].intValue
        totalRecovered = data["recovered"].intValue
        totalDeceased = data["deceased"].intValue
    }
}

class Home {
    
    var name: String!
    var caseCount: Case?
    
    init(name: String, caseCount_: Case?) {
        self.name = name
        
        guard let _caseCount = caseCount_ else {
            print("No cases found")
            return
        }
        
        caseCount = _caseCount
    }
    
    
    
    
}


