//
//  FundraisersTableViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//
import CoreLocation
import UIKit

class FundraisersTableViewController: UITableViewController {
    
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    var fundraiserStore = FundraiserStore()
    
    var location: CLLocation!
    
    var coordinateString: String? = nil
    
    var fundraisers: [Fundraiser] = [] {
        didSet {
            update()
        }
    }
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    let beginDateFormatter = DateFormatter()
    
    let fundraiserCellIdentifier = "FundraiserCell"
    
    /*@IBAction func searchButtonTapped(_ sender: Any) {
     let fundraiserSearchVC = self.storyboard!.instantiateViewController(withIdentifier: "FundraiserSearchView") as! FundraiserSearchViewController
     
     fundraiserSearchVC.fundraiserStore = fundraiserStore
     
     self.navigationController?.pushViewController(fundraiserSearchVC, animated:
     true)
     }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fundraisers"
        
        if coordinateString == nil {
            coordinateString = "33.7523938,-84.3915388"
        }
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = activityIndicatorView
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.activityIndicatorView = activityIndicatorView
        
        fundraiserStore.fetchLocalFundraisers(coordinate: coordinateString!) { result in
            switch result {
            case let .success(array) :
                self.fundraisers = array
                
            case let .failure(error) :
                print("failed to get events: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to get Fundraisers.  Try again.")
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
        fundraiserStore.fetchLocalFundraisers(coordinate: coordinateString!) { result in
            switch result {
            case let .success(array) :
                
                
                OperationQueue.main.addOperation {
                    self.fundraisers = array
                    return
                }
                
                
            case let .failure(error) :
                print("failed to get events: \(error)")
                self.displayMyAlertMessage(userMessage: "Failed to get Fundraisers.  Try again.")
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
        
        return fundraisers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: fundraiserCellIdentifier, for: indexPath)
        
        let isoStartDate = fundraisers[indexPath.row].start
        
        
        beginDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let beginDate = beginDateFormatter.date(from: isoStartDate)
        
        
        startDateFormatter.dateStyle = .medium
        startDateFormatter.timeStyle = .none
        startTimeFormatter.dateStyle = .none
        startTimeFormatter.timeStyle = .short
        
        startDateFormatter.string(from: beginDate!)
        startTimeFormatter.string(from: beginDate!)
        
        location = CLLocation(latitude: (fundraisers[indexPath.row].coordinates[1]), longitude: (fundraisers[indexPath.row].coordinates[0]))
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if let pm = placemarks?.first
            {
                
                cell.detailTextLabel?.text = "\(pm.locality!.uppercased())\n\(self.startDateFormatter.string(from: beginDate!))   \(self.startTimeFormatter.string(from: beginDate!))"
            }
        })
        
        cell.textLabel?.text = fundraisers[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let fundraiserVC = self.storyboard!.instantiateViewController(withIdentifier: "FundraiserView") as! FundraiserViewController
        
        fundraiserVC.fundraiser = fundraisers[indexPath.row]
        
        
        self.navigationController?.pushViewController(fundraiserVC, animated:
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
