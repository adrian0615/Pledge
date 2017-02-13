//
//  EventsTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    var eventStore = EventStore()
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    var loggedIn: Bool = false
    
    var events: [Event] = [] {
        didSet {
            update()
        }
    }
    
    let eventCellIdentifier = "EventCell"
    
    
    func mustLogin() {
        
    }
    
    func addEvent() {
        if loggedIn == false {
            let acNoNetwork = UIAlertController(title: "Must Login to Add Event", message: nil, preferredStyle: .alert)
            
           // acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
        } else if loggedIn == true && individual != nil {
            
            
        } else if loggedIn == true && organization != nil {
            
            
        }
            
        }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        
        

        eventStore.fetchUpcomingEvents { result in
            switch result {
            case let .success(array) :
                print(array)
                
                self.events = array
                
            case let .failure(error) :
                print("failed to get events: \(error)")
            }
        }

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath)
        
        
        cell.textLabel?.text = events[indexPath.row].name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.blue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let eventVC = self.storyboard!.instantiateViewController(withIdentifier: "EventView") as! EventViewController
        
        eventVC.event = events[indexPath.row]
        eventVC.individual = individual
        eventVC.organization = organization
        eventVC.individualPost = individualPost
        eventVC.organizationPost = organizationPost
        eventVC.loggedIn = loggedIn
        
        self.navigationController?.pushViewController(eventVC, animated:
            true)
        
        
    }
    
    
    func update() {
        OperationQueue.main.addOperation {
            
            self.tableView.reloadData()
            return
        }
    }

}
