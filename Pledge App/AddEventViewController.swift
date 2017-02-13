//
//  AddEventViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/12/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var eventStore = EventStore()
    var individualPost = IndividualPost()
    var organizationPost = OrganizationPost()
    var individual: Individual? = nil
    var organization: Organization? = nil
    var events: [Event] = []
    var loggedIn: Bool = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
