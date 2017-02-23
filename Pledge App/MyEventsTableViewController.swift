//
//  MyEventsTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class MyEventsTableViewController: UITableViewController {
    
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
    var eventPost = EventPost()
    
    let userType = UserDefaults.standard.string(forKey: "type")
    let userId = UserDefaults.standard.string(forKey: "userId")
    let hostId = UserDefaults.standard.string(forKey: "hostId")
    
    
    var events: [Event] = [] {
        didSet {
            update()
        }
    }
    
    let eventCellIdentifier = "MyEventCell"
    
    func addButtonTapped(_ sender: UIBarButtonItem) {
        
        if !isUserLoggedIn {
            let ac = UIAlertController(title: "Must Login to Add Event", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:mustLogin))
            
            self.present(ac, animated: true)
        }
        
        let addEventVC = self.storyboard!.instantiateViewController(withIdentifier: "AddEventView") as! AddEventViewController
        self.navigationController?.pushViewController(addEventVC, animated:
            true)
        
    }
    
    func logoutButtonTapped(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        let homeVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = "My Events"
        
        if !isUserLoggedIn {
            let acNoNetwork = UIAlertController(title: "Must Login to View My Events", message: nil, preferredStyle: .alert)
            
            acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
            
            self.present(acNoNetwork, animated: true)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:
            "Add Event", style: .plain, target: self, action:
            #selector(addButtonTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:
            "Logout", style: .plain, target: self, action:
            #selector(logoutButtonTapped))
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
       
        
        eventPost.postMyEvents(userId: userId!) { result in
         switch result {
         case let .success(array) :
         print(array)
         
         self.events = array
         
         case let .failureLogin(error) :
         print("Failed to Get Events \(error)")
         
         self.displayMyAlertMessage(userMessage: "Unable to Get Events.  Try Again.")
         
         
         case let .failure(error) :
         print("Failed to Save Event \(error)")
         
         self.displayMyAlertMessage(userMessage: "Get Events.  Try Again.")
         }
         }
        
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
    }
    
    
    
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        eventPost.postMyEvents(userId: userId!) { result in
         switch result {
         case let .success(array) :
        
         
         self.events = array
         
         case let .failureLogin(error) :
         print("Failed to Get Events \(error)")
         
         self.displayMyAlertMessage(userMessage: "Unable to Get Events.  Try Again.")
         
         
         case let .failure(error) :
         print("Failed to Save Event \(error)")
         
         self.displayMyAlertMessage(userMessage: "Get Events.  Try Again.")
         }
         }
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            return
        }
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        OperationQueue.main.addOperation {
            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            myAlert.addAction(action)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
    }
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: eventCellIdentifier, for: indexPath)
        
        
        
        if hostId == events[indexPath.row].hostId {
            cell.textLabel?.text = "\(events[indexPath.row].name) - Hosting"
            cell.detailTextLabel?.text = "\((events[indexPath.row].type).capitalized)\n\(events[indexPath.row].location) -\((events[indexPath.row].city).uppercased())\n\(Date(timeIntervalSince1970: (events[indexPath.row].startTime) / 1000))"
        } else {
            cell.textLabel?.text = "\(events[indexPath.row].name) - Attending"
            cell.detailTextLabel?.text = "\((events[indexPath.row].type).capitalized)\n\(events[indexPath.row].location) -\((events[indexPath.row].city).uppercased())\n\(Date(timeIntervalSince1970: (events[indexPath.row].startTime) / 1000))"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let myEventVC = self.storyboard!.instantiateViewController(withIdentifier: "MyEventView") as! MyEventViewController
        
        myEventVC.event = events[indexPath.row]
        
        
        
        self.navigationController?.pushViewController(myEventVC, animated:
            true)
        
        
    }
    
    
    func update() {
        
        
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            return
        }
    }
    
}
