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
    
    
    var fundraiserStore = FundraiserStore()
    
    var location: CLLocation!
    
    var fundraisers: [Fundraiser] = [] {
        didSet {
            update()
        }
    }
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    let beginDateFormatter = DateFormatter()
    
    let fundraiserCellIdentifier = "FundraiserCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fundraisers"

        fundraiserStore.fetchLocalFundraisers { result in
            switch result {
            case let .success(array) :
                print(array)
                
                self.fundraisers = array
                
            case let .failure(error) :
                print("failed to get events: \(error)")
            }
        }
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
            
            self.tableView.reloadData()
            return
        }
    }

}
