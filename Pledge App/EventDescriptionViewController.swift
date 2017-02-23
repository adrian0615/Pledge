//
//  EventDescriptionViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/17/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventDescriptionViewController: UIViewController {
    
    
    var name: String = " "
    var host: String = " "
    var location: String = " "
    var address: String = " "
    var city: String = " "
    var state: String = " "
    var zipString: String = " "
    var type: String = " "
    var details: String = " "
    
    var startDate = Date()
    var endDate = Date()
    
    @IBOutlet var detailsTextView: UITextView!
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        
        let addEventVC = self.storyboard!.instantiateViewController(withIdentifier: "AddEventView") as! AddEventViewController
        
        if detailsTextView.text != nil {
            details = detailsTextView.text
            
        }
        
        addEventVC.name = name
        addEventVC.type = type
        addEventVC.host = host
        addEventVC.location = location
        addEventVC.address = address
        addEventVC.city = city
        addEventVC.state = state
        addEventVC.zipString = zipString
        addEventVC.details = details
        
        addEventVC.startDate = startDate
        addEventVC.endDate = endDate
        
        self.navigationController?.pushViewController(addEventVC, animated:
            true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Description"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        detailsTextView.text = details
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
