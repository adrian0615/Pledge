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
    
    let userType = UserDefaults.standard.string(forKey: "type")
    let userId = UserDefaults.standard.string(forKey: "userId")
    let hostId = UserDefaults.standard.string(forKey: "hostId")
    
    var eventPost = EventPost()
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
    
    @IBAction func descritptionButtonTapped(_ sender: Any) {
        
        let descriptionVC = self.storyboard!.instantiateViewController(withIdentifier: "DescriptionView") as! DescriptionViewController
        
        descriptionVC.event = event
        
        self.navigationController?.pushViewController(descriptionVC, animated:
            true)
    }
    
    @IBAction func rsvpButtonTapped(_ sender: Any) {
        
        // if not logged in
        if !isUserLoggedIn {
            let ac = UIAlertController(title: "Must Login to RSVP", message: nil, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler:mustLogin))
            
            self.present(ac, animated: true)
        }
        
        
        let ac = UIAlertController(title: "Attend \(event!.name)?", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler:yesRSVP))
        ac.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(ac, animated: true)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        title = "Event"
        
        if isUserLoggedIn {
            
            
            if userType == "organization"  {
                rsvpButton.isHidden = true
                
            }
            
            
            
            if userType == "individual" {
                
                if event!.userIds.contains(userId!) {
                    title = "Attending"
                    rsvpButton.isHidden = true
                }
            }
            
            if event?.hostId == hostId {
                title = "Hosting"
                rsvpButton.isHidden = true
            }
        }
        
        startDateFormatter.dateStyle = .medium
        startDateFormatter.timeStyle = .none
        endDateFormatter.dateStyle = .medium
        endDateFormatter.timeStyle = .none
        
        let startDate = startDateFormatter.string(from: Date(timeIntervalSince1970: (event!.startTime) / 1000))
        
        let endDate = endDateFormatter.string(from: Date(timeIntervalSince1970: (event!.endTime) / 1000))
        
        eventNameLabel?.text = event?.name
        typeLabel?.text = event?.type.capitalized
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
            
            let endTime = endTimeFormatter.string(from: Date(timeIntervalSince1970: (event!.endTime) / 1000))
            
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
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    
    func mustLogin(action: UIAlertAction!) {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
        
        self.navigationController?.pushViewController(loginVC, animated:
            true)
        
        return
    }
    
    func yesRSVP(action: UIAlertAction!) {
        
        
        eventPost.postRSVP(userId: userId!, eventId: (event?.eventId)!) { result in
            switch result {
            case let .success(array) :
                
                
                OperationQueue.main.addOperation {
                    let myAlert = UIAlertController(title: "RSVP Successful", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { action in
                        
                        let myEventsVC = self.storyboard!.instantiateViewController(withIdentifier: "MyEventsView") as! MyEventsTableViewController
                        
                        myEventsVC.events = array
                        
                        self.rsvpButton.isHidden = true
                        self.title = "Attending"
                        
                        self.tabBarController?.selectedIndex = 1
                    }
                    
                    myAlert.addAction(okAction)
                    
                    self.present(myAlert, animated: true, completion: nil)
                }
                
            case let .failureLogin(error) :
                print("failed to RSVP: \(error)")
                
                
            case let .failure(error) :
                print("failed to RSVP: \(error)")
            }
        }
        
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
        
    }
    
}
