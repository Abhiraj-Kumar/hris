//
//  LoginRequest.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit
import Alamofire

class LoginRequest: NSObject {
    
    class func makeLoginRequest(){
        let url = "http://hris.proptiger.com/login/index?userid=&pwd=&login=Login"
        Alamofire.request(.POST,url).responseJSON{_ in 
            
        }
    }

}
