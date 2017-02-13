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
    var eventStore = EventStore()
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    var event: Event? = nil
    
    var loggedIn: Bool = false
    
    
    
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var eventMap: MKMapView!
    
    
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pledge"
        
        
        
        //if organization == nil {
        
        //}
        
        eventNameLabel?.text = event?.name
        descriptionLabel?.text = event?.details
         cityLabel?.text = event?.city
        locationLabel?.text = event?.location
        addressLabel?.text = "\(event!.address), \(event!.city), \(event!.state), \(event!.zip)"
        dateLabel?.text = "\(Date(timeIntervalSince1970: (event?.startTime)! / 1000)) - \(Date(timeIntervalSince1970: (event?.endTime)! / 1000))"
        
        pointAnnotation = MKPointAnnotation()
        
        eventLocationMap(address: "\(event!.address), \(event!.city), \(event!.state), \(event!.zip)")
    }
    
    
    
    func mustLogin() {
        
    }
    
    func checkIn() {
        if loggedIn == false {
            let acNoNetwork = UIAlertController(title: "Must Login to RSVP", message: nil, preferredStyle: .alert)
            
            //acNoNetwork.addAction(UIAlertAction(title: "OK", style: .default, handler: self.mustLogin))
        } else {
            self.navigationController?.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationController?.navigationItem.rightBarButtonItem?.title = "Attend"
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
                let span = MKCoordinateSpanMake(50, 40)
                let region = MKCoordinateRegionMake(coordinate!, span)
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
