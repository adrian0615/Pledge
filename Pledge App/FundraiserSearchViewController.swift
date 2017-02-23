//
//  FundraiserSearchViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI

class FundraiserSearchViewController: UIViewController {
    
    var coordinateString: String? = nil

    var fundraiserStore = FundraiserStore()
    
    var fundraisers: [Fundraiser] = []

    @IBOutlet var zipField: UITextField!
    @IBAction func searchButtonTapped(_ sender: Any) {
        if (zipField.text?.isEmpty)! {
            displayMyAlertMessage(userMessage: "Please enter a city")
        }
        
        if (zipField.text?.characters.count)! < 5 {
            displayMyAlertMessage(userMessage: "Please enter a valid zip code")
        }
        
        fundraiserSearchLocation(zipCode: zipField.text!)
        
        
        if coordinateString == nil {
           coordinateString = "33.7523938,-84.3915388"
        }
        
        fundraiserStore.fetchLocalFundraisers(coordinate: coordinateString!) { result in
            switch result {
            case let .success(array) :
                
                OperationQueue.main.addOperation {

                self.fundraisers = array
                
                if self.fundraisers.count == 0 {
                    self.displayMyAlertMessage(userMessage: "No Results Found")
                }
                
                let fundraiserResultsVC = self.storyboard!.instantiateViewController(withIdentifier: "FundraiserResultsView") as! FundraiserResultsTableViewController
                
                fundraiserResultsVC.fundraisers = self.fundraisers
                
                self.navigationController?.pushViewController(fundraiserResultsVC, animated:
                    true)
                    
                    return
                }
                
            case let .failure(error) :
                print("failed to get events: \(error)")
            }
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fundraiser Search"
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fundraiserSearchLocation(zipCode: String) {
        var location = CLLocation()
        var placement = CLLocationCoordinate2D()
        
        CLGeocoder().geocodeAddressString(zipCode, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error ?? Error.self)
                return
            }
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                location = (placemark?.location)!
                placement = location.coordinate
                
            } else {
                print("Can't find coordinates")
            }
        })
       coordinateString = "\(placement.latitude),\(placement.longitude)"
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

    

}
