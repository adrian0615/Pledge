//
//  CharitiesTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharitiesTableViewController: UITableViewController {
    
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var charityPost = CharityPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    
    
    
    var loggedIn: Bool = false
    
    var charities: [Charity] = [] {
        didSet {
            update()
        }
    }
    
    let charityCellIdentifier = "CharityCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Charities"
        
        charityPost.fetchGACharities(state: .GA) { result in
            switch result {
            case let .success(array) :
                print(array)
                
                self.charities = array
                
            case let .failure(error) :
                print("failed to get charities: \(error)")
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
        return charities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: charityCellIdentifier, for: indexPath)
        
        
        cell.textLabel?.text = charities[indexPath.row].name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.blue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let charityVC = self.storyboard!.instantiateViewController(withIdentifier: "CharityView") as! CharityViewController
        
        charityVC.charity = charities[indexPath.row]
        charityVC.individual = individual
        charityVC.organization = organization
        charityVC.individualPost = individualPost
        charityVC.organizationPost = organizationPost
        charityVC.loggedIn = loggedIn
        
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
