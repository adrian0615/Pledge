//
//  EventDateViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/13/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventDateViewController: UIViewController {
    
    var name: String = " "
    var host: String = " "
    var location: String = " "
    var address: String = " "
    var city: String = " "
    var state: String = " "
    var zipString: String = " "
    var type: String = " "
    var details: String = " "


    
    
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBAction func startDateValueChanged(_ sender: Any) {
        

        endDatePicker.date = startDatePicker.date
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        
        let addEventVC = self.storyboard!.instantiateViewController(withIdentifier: "AddEventView") as! AddEventViewController
        
        addEventVC.startDate = startDatePicker.date
        addEventVC.endDate = endDatePicker.date
        
        addEventVC.name = name
        addEventVC.type = type
        addEventVC.host = host
        addEventVC.location = location
        addEventVC.address = address
        addEventVC.city = city
        addEventVC.state = state
        addEventVC.zipString = zipString
        addEventVC.details = details
        
        
        
        self.navigationController?.pushViewController(addEventVC, animated:
            true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Event Times"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
