//
//  BasicEmployeeInfoMapper.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.


import UIKit
 import JavaScriptCore

class BasicEmployeeInfoMapper: NSObject {
    
   class func mapEmployeeInfoFromJavaScriptRecievedFromServer(script:String)->[AnyObject]?{
        let context = JSContext(virtualMachine: JSVirtualMachine())
        context.evaluateScript(script)
        
        let employeeArray: JSValue = context.objectForKeyedSubscript("employees")
        if  employeeArray.isArray{
            return employeeArray.toArray()
        }else{
            return nil
        }
       
    }

}
