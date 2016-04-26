//
//  MasterViewController.swift
//  Hris
//
//  Created by proptiger on 26/04/16.
//  Copyright © 2016 proptiger. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, EmployeeDataAccessProtocol,UISearchBarDelegate{

    var detailViewController: DetailViewController? = nil
    var employeeAccessObject = EmployeeDataAccessObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        employeeAccessObject.delegate = self
        LoginRequest.makeLoginRequest()
        
        // Do any additional setup after loading the view, typically from a nib.
       
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = employeeAccessObject.employeeList[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeAccessObject.employeeList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let employee = employeeAccessObject.employeeList[indexPath.row]
        cell.textLabel!.text = employee.info
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

     func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        employeeAccessObject.updateEmployeeListForNameBeginningWithString(searchText)
    }
    
    
    func employeeListHasChanged() {
        self.tableView.reloadData()
    }


}

