//
//  CharitiesTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharitiesTableViewController: UITableViewController {
    
    weak var activityIndicatorView: UIActivityIndicatorView!

    var charityPost = CharityPost()
    
    var city: String? = nil
    var state: String? = nil
    
    
    var charities: [Charity] = [] {
        didSet {
            update()
        }
    }
    
    let charityCellIdentifier = "CharityCell"
    
    @IBAction func searchBarTapped(_ sender: UIBarButtonItem) {
        let charitySearchVC = self.storyboard!.instantiateViewController(withIdentifier: "CharitySearchView") as! CharitySearchViewController
        
        
        charitySearchVC.charityPost = charityPost
        charitySearchVC.city = city
        charitySearchVC.state = state
        
        self.navigationController?.pushViewController(charitySearchVC, animated:
            true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Charities"
        
        if city == nil {
            city = "Atlanta"
        }
        
        if state == nil {
            state = "GA"
        }
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        
        charityPost.fetchLocalCharitiesWithCategory(state: state!, city: city!, category: "A") { result in
            switch result {
            case let .success(array) :
            
                OperationQueue.main.addOperation {
                    self.charities = array
                    return
                }
                
            case let .failure(error) :
                print("failed to get charities: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to get Charities.  Try again.")
            }
        }
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.startAnimating()
        
        self.update()
        
        
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        charityPost.fetchLocalCharitiesWithCategory(state: state!, city: city!, category: "R") { result in
            switch result {
            case let .success(array) :
                self.charities = array
                
            case let .failure(error) :
                print("failed to get charities: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to Make Changes.  Try again.")
            }
        }
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            return
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
            return
        }
    }
    
    
}
