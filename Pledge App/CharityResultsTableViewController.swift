//
//  CharityResultsTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharityResultsTableViewController: UITableViewController {
    
    
    
    var charities: [Charity] = [] {
        didSet {
            update()
        }
    }
    
    let charityCellIdentifier = "CharityResultsCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Results"
        
        navigationItem.rightBarButtonItem = nil
        
        navigationController?.navigationBar.tintColor = UIColor.white
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
        
        return charities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: charityCellIdentifier, for: indexPath)
        
        
        cell.textLabel?.text = charities[indexPath.row].name
        cell.detailTextLabel?.text = "\(charities[indexPath.row].category)\n\(charities[indexPath.row].city)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let charityVC = self.storyboard!.instantiateViewController(withIdentifier: "CharityView") as! CharityViewController
        
        charityVC.charity = charities[indexPath.row]
        
        
        self.navigationController?.pushViewController(charityVC, animated:
            true)
        
        
    }
    
    
    func update() {
        OperationQueue.main.addOperation {
            
            self.tableView.reloadData()
            return
        }
    }
}
