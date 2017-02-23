//
//  DescriptionViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/16/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var fundraiser: Fundraiser? = nil
    var event: Event? = nil
    
    
    
    @IBOutlet var detailsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Description"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        if fundraiser != nil {
            detailsTextView.text = fundraiser?.description
        }
        
        
        if event != nil {
            detailsTextView.text = event?.details
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
