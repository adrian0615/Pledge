//
//  EventDateViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/13/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventDateViewController: UIViewController {
    
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBAction func startDateValueChanged(_ sender: Any) {
        
        
        
        endDatePicker.date = startDatePicker.date
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        
        let addEventVC = self.storyboard!.instantiateViewController(withIdentifier: "AddEventView") as! AddEventViewController
        
        addEventVC.startDate = startDatePicker.date
        addEventVC.endDate = endDatePicker.date
        
        
        self.navigationController?.pushViewController(addEventVC, animated:
            true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Event Times"
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}