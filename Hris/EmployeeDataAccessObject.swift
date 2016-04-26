//
//  EmployeeDataAccessObject.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit


protocol EmployeeDataAccessProtocol{
    func employeeListHasChanged()
}

class EmployeeDataAccessObject: NSObject {
    var employeeList = [EmployeeDetail]()
    private var allEmployeeList:[EmployeeDetail] =  [EmployeeDetail]()
    var delegate:EmployeeDataAccessProtocol?
    
    override init(){
        super.init()
        EmployeeListFetcher.fetchallEmployeeDetail { (employeeDetailArray, error) in
            if (error == nil){
                if let employeeDetailArray = employeeDetailArray{
                    print(employeeDetailArray.count)
                    self.allEmployeeList = employeeDetailArray.sort { $0.info < $1.info }
                    self.employeeList = self.allEmployeeList
                    self.delegate?.employeeListHasChanged()

                }
            }
        }
    }
    
    func updateEmployeeListForNameBeginningWithString(string:String){
        if string == "" || string.characters.count == 0{
            employeeList = allEmployeeList
            self.delegate?.employeeListHasChanged()
            return
        }
        employeeList.removeAll()
        for object in allEmployeeList{
            if object.info.capitalizedString.hasPrefix(string.capitalizedString){
            employeeList.insert(object, atIndex: 0)
            }else{
            if object.info.capitalizedString.containsString(string.capitalizedString){
            employeeList.append(object)
                }
          
        }
        }
        self.delegate?.employeeListHasChanged()
        
    }
    

}
