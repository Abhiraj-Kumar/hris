//
//  DetailViewController.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    var detailItem: EmployeeDetail? {
        didSet {
            EmployeeListFetcher.getEmployeeDetailofId(detailItem?.employeeId ?? ""){ (employee, error) in
                self.detailItem?.phoneNumber = employee.phoneNumber
                self.configureView()
            }
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.info
            }
            if let phoneNumber = detail.phoneNumber{
                callButton?.hidden = false
                phoneNumberLabel?.text = phoneNumber
                
            }else{
                callButton?.hidden = true
                phoneNumberLabel?.text = "Phone Number not availbale"
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedOnCallButton(sender: AnyObject) {
        if let mobileNumber:String = detailItem?.phoneNumber{
            if let url = NSURL(string: "tel://\(mobileNumber)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
        
    }
    
}

