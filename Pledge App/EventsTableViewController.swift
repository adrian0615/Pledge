//
//  EventsTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
    var eventStore = EventStore()
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    
    
    
    var events: [Event] = [] {
        didSet {
            update()
        }
    }
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    
    
    let eventCellIdentifier = "EventCell"
    
    
    
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    
    
    func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    func loginButtonTapped(_ sender: UIBarButtonItem) {
        
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Events"
        
        if isUserLoggedIn {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title:
                "Logout", style: .plain, target: self, action:
                #selector(logoutButtonTapped))
            
        } else {
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title:
                "Login", style: .plain, target: self, action:
                #selector(loginButtonTapped))
        }
        
        
        
        eventStore.fetchUpcomingEvents { result in
            switch result {
            case let .success(array) :
                print(array)
                
                self.events = array
                
            case let .failure(error) :
                print("failed to get events: \(error)")
            }
        }
        
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
        
        
        startDateFormatter.dateStyle = .medium
        startDateFormatter.timeStyle = .none
        
        startTimeFormatter.dateStyle = .none
        startTimeFormatter.timeStyle = .short
        
        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = "\((events[indexPath.row].type).capitalized)\n\(events[indexPath.row].location) - \((events[indexPath.row].city).uppercased())\n\(startDateFormatter.string(from: Date(timeIntervalSince1970: (events[indexPath.row].startTime) / 1000)))  \(startTimeFormatter.string(from: Date(timeIntervalSince1970: (events[indexPath.row].startTime) / 1000)))"
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let eventVC = self.storyboard!.instantiateViewController(withIdentifier: "EventView") as! EventViewController
        
        eventVC.event = events[indexPath.row]
        
        
        
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
