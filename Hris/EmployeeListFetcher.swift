//
//  EmployeeListFetcher.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class EmployeeListFetcher: NSObject {
    
    
    class func fetchallEmployeeDetail(completionBlock:
        ((employeeList:[EmployeeDetail]?,error:NSError?)->Void)?){
        
        let url = "http://hris.proptiger.com/js/employee.js"
        Alamofire.request(.GET,url)
        .responseString { (response) in
            if response.result.error != nil{
                completionBlock?(employeeList: nil,error: response.result.error)
                return
            }
            switch response.result{
            case .Failure(let error):
                completionBlock?(employeeList: nil,error: error)
                return
            case .Success(let value):
               let employee =  BasicEmployeeInfoMapper.mapEmployeeInfoFromJavaScriptRecievedFromServer(value)
               if employee == nil{
                let userInfoKeyForError = [NSLocalizedDescriptionKey:"Error Parsing Server Response"]
                let error = NSError(domain: "ParsingDomain", code: 1, userInfo: userInfoKeyForError)
                 completionBlock?(employeeList: nil,error: error)
                return
                }else{
                let employeeDetail:[EmployeeDetail] =
                    employee!.map{
                    let detail = EmployeeDetail()
                    detail.info = $0 as? String ?? "Error"
                    return detail
                        }.filter{
                            $0.info != "" &&
                                $0.info != "-"
                }
                completionBlock?(employeeList: employeeDetail,error: nil)
                }
                
            }

        }
    }
    
    class func getEmployeeDetailofId(employeeId:String,completionBlock:
        ((employeeDetail:EmployeeDetail,error:NSError?)->Void)?){
        let url = "http://hris.proptiger.com/ajax/get-employee-details-by-ajax?data=\(employeeId)"
        Alamofire.request(.GET,url)
        .responseJSON { (response) in
            
           
            let employee = EmployeeDetail()
            if let responsedict = response.result.value as? [String:AnyObject]{
                 _ = JSON(response.result.value!)
                if let mobile = responsedict["Mobile"] as? String{
                    employee.phoneNumber = mobile
                }
                 completionBlock?(employeeDetail: employee,error: nil)
            }
        }
    }

}
