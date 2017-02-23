//
//  EventResultsTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventResultsTableViewController: UITableViewController {
    
    var events: [Event] = [] {
        didSet {
            update()
        }
    }
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    
    
    let eventCellIdentifier = "EventResultsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Results"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationItem.rightBarButtonItem = nil

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.update()
        
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
