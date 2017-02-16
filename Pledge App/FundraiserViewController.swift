//
//  FundraiserViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//
import CoreLocation
import UIKit

class FundraiserViewController: UIViewController {
    
    var location: CLLocation!
    
    
    var fundraiser: Fundraiser? = nil
    
    let beginDateFormatter = DateFormatter()
    
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBAction func descriptionButtonTapped(_ sender: Any) {
        
        let descriptionVC = self.storyboard!.instantiateViewController(withIdentifier: "DescriptionView") as! DescriptionViewController
        
        descriptionVC.fundraiser = fundraiser
        
        self.navigationController?.pushViewController(descriptionVC, animated:
            true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fundraiser"
        
        let isoStartDate = fundraiser?.start
        
        
        beginDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let beginDate = beginDateFormatter.date(from: isoStartDate!)
        
        startDateFormatter.dateStyle = .medium
        startDateFormatter.timeStyle = .none
        startTimeFormatter.dateStyle = .none
        startTimeFormatter.timeStyle = .short
        
        startDateFormatter.string(from: beginDate!)
        startTimeFormatter.string(from: beginDate!)
        
        
        
        
        titleLabel.text = fundraiser?.title
        dateLabel.text = "\(startDateFormatter.string(from: beginDate!))   \(startTimeFormatter.string(from: beginDate!))" 
        
        
        location = CLLocation(latitude: (fundraiser?.coordinates[1])!, longitude: (fundraiser?.coordinates[0])!)
        
        fundraiserLocation(location: location)

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fundraiserLocation(location: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if let pm = placemarks?.first
            {
                
                self.addressLabel?.text = "\(pm.subThoroughfare ?? "") \(pm.thoroughfare  ?? "") \(pm.locality ?? "") \(pm.administrativeArea ?? "") \(pm.postalCode ?? "")"
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
