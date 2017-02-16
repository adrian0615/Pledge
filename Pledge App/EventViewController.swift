//
//  EventViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/11/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI


class EventViewController: UIViewController {
    
    let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
    var eventStore = EventStore()
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    var event: Event? = nil
    
    
    let startDateFormatter = DateFormatter()
    let startTimeFormatter = DateFormatter()
    let endDateFormatter = DateFormatter()
    let endTimeFormatter = DateFormatter()
    
    
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var startEndLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var eventMap: MKMapView!
    @IBOutlet var hostLabel: UILabel!
    @IBOutlet var rsvpButton: UIButton!
    
    
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

    @IBAction func rsvpButtonTapped(_ sender: Any) {

        if !isUserLoggedIn {
            let ac = UIAlertController(title: "Must Login to RSVP", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:mustLogin))
            
            self.present(ac, animated: true)
        }
        
        if event?.hostId == individual?.hostId || event?.hostId == organization?.hostId {
            //cancel event closure
            
            //If successful, confirm that event is canceled and Go back to first tableview of tab bar and reload view page
            
        }
        
            let ac = UIAlertController(title: "Attend \(event!.name)?", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler:yesRSVP))
            ac.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(ac, animated: true)
    }
    
    func editButtonTapped(_ sender: UIBarButtonItem) {
        print("button tapped")
        //Go to edit event page
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if event?.hostId == individual?.hostId || event?.hostId == organization?.hostId {
            title = "Hosting"
            rsvpButton.setTitle("Cancel Event", for: .normal)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title:
                "Edit", style: .plain, target: self, action:
                #selector(editButtonTapped))
        }
        
        title = "Event"
        
        
        
        if organization != nil && event?.hostId != organization?.hostId  {
            rsvpButton.isHidden = true
            
        }
        if individual != nil {
        if event!.userIds.contains((individual?.userId)!) {
            title = "Attending"
            rsvpButton.isHidden = true
        }
        }
        
        startDateFormatter.dateStyle = .medium
        startDateFormatter.timeStyle = .none
        endDateFormatter.dateStyle = .medium
        endDateFormatter.timeStyle = .none
        
        let startDate = startDateFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
        
        let endDate = endDateFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
        
        eventNameLabel?.text = event?.name
        typeLabel?.text = event?.type
        hostLabel?.text = "Hosted by: \(event!.host)"
        detailsLabel?.text = event?.details
        locationLabel?.text = event?.location
        addressLabel?.text = "\(event!.address), \(event!.city), \(event!.state), \(event!.zip)"
        startLabel?.text = startDate
        
        if startDate == endDate {
            startTimeFormatter.dateStyle = .none
            startTimeFormatter.timeStyle = .short
            endTimeFormatter.dateStyle = .none
            endTimeFormatter.timeStyle = .short
            
            let startTime = startTimeFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
            
            let endTime = endTimeFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
            
            startEndLabel?.text = "\(startTime) - \(endTime)"
            
        } else {
            
            startTimeFormatter.dateStyle = .medium
            startTimeFormatter.timeStyle = .short
            endTimeFormatter.dateStyle = .medium
            endTimeFormatter.timeStyle = .short
            
            let startTime = startTimeFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
            
            let endTime = endTimeFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
            
            startEndLabel?.text = "\(startTime) - \(endTime)"
        }
        

        pointAnnotation = MKPointAnnotation()
        
        eventLocationMap(address: "\(event!.address), \(event!.city), \(event!.state), \(event!.zip)")
    }
    
    
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    func yesRSVP(action: UIAlertAction!) {
        
        
        OperationQueue.main.addOperation {
            
            //RSVP Closure
            self.rsvpButton.isHidden = true
            let eventsVC = self.storyboard!.instantiateViewController(withIdentifier: "EventsView") as! EventsTableViewController
            
            self.navigationController?.pushViewController(eventsVC, animated:
                true)
            return
        }
        
        
        
        
        return
    }

    
    func eventLocationMap(address: String) {
        CLGeocoder().geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if error != nil {
                print(error ?? Error.self)
                return
            }
            if (placemarks?.count)! > 0 {
                let placemark = placemarks?[0]
                let location = placemark?.location
                let coordinate = location?.coordinate
                
                self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
                self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
                self.eventMap.centerCoordinate = self.pointAnnotation.coordinate
                self.eventMap.addAnnotation(self.pinAnnotationView.annotation!)
                //Need to work on zooming in on map
                let span = MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
                let region = MKCoordinateRegion(center: coordinate!, span: span)
                self.eventMap.setRegion(region, animated: true)
                } else {
                    print("Can't find Address")
                }
            })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
