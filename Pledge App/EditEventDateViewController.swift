//
//  EditEventDateViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EditEventDateViewController: UIViewController {
    
    @IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var endDatePicker: UIDatePicker!
    
    @IBAction func startDateValueChanged(_ sender: Any) {
        
        
        
        endDatePicker.date = startDatePicker.date
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        
        
        
        let editEventVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventView") as! EditEventViewController
        
        editEventVC.startDate = startDatePicker.date
        editEventVC.endDate = endDatePicker.date
        
        
        self.navigationController?.pushViewController(editEventVC, animated:
            true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Times"
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
