//
//  EditEventDescriptionViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class EditEventDescriptionViewController: UIViewController {
    
    @IBOutlet var detailsTextView: UITextView!
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        
        let editEventVC = self.storyboard!.instantiateViewController(withIdentifier: "EditEventView") as! EditEventViewController
        
        if detailsTextView.text != nil {
            editEventVC.details = detailsTextView.text
            
        }
        
        self.navigationController?.pushViewController(editEventVC, animated:
            true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Description"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
