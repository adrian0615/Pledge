//
//  EditEventDateViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EditEventDateViewController: UIViewController {
    
    
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
        
        
        
        
        let editEventVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventView") as! EditEventViewController
        
        
        editEventVC.name = name
        editEventVC.type = type
        editEventVC.host = host
        editEventVC.location = location
        editEventVC.address = address
        editEventVC.city = city
        editEventVC.state = state
        editEventVC.zipString = zipString
        editEventVC.details = details
        
        editEventVC.startDate = startDatePicker.date
        editEventVC.endDate = endDatePicker.date
        
        
        self.navigationController?.pushViewController(editEventVC, animated:
            true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Times"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
