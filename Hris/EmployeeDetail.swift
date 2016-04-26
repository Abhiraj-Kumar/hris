//
//  EmployeeDetail.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit

class EmployeeDetail: NSObject {
    var info:String = "" {
        didSet{
            if let bracketStartRange = info.rangeOfString("("),
                bracketEndRange = info.rangeOfString(")"){
                let range = bracketStartRange.startIndex.successor()...bracketEndRange.startIndex.predecessor()
                self.employeeId = info.substringWithRange(range)
            }
            
        }
    }
    var employeeId:String?
    var phoneNumber:String?
}
