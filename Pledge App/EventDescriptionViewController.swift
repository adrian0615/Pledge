//
//  EventDescriptionViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/17/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EventDescriptionViewController: UIViewController {
    
    @IBOutlet var detailsTextView: UITextView!
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        
        let addEventVC = self.storyboard!.instantiateViewController(withIdentifier: "AddEventView") as! AddEventViewController
        
        if detailsTextView.text != nil {
            addEventVC.details = detailsTextView.text
            
        }
        
        self.navigationController?.pushViewController(addEventVC, animated:
            true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Description"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
