//
//  CharitySearchViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/20/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import UIKit

class CharitySearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let types = ["Arts & Culture", "Animal Related", "Civil Rights", "Community Improvement", "Disaster Relief", "Education", "Environmental", "Housing & Shelter", "Human Services", "Mental Health", "Nutrition", "Philanthropy & Voluntarism", "Public Society", "Youth Development"]

    var type: String = " "
    var searchCode: String = " "
    var charities: [Charity] = []
    var charityPost = CharityPost()
    var city: String? = nil
    var state: String? = nil
    

    @IBOutlet var typePicker: UIPickerView!
    @IBAction func searchButtonTapped(_ sender: Any) {
        if type == "Arts & Culture" {
            searchCode = "A"
        }
        if type == "Animal Related" {
            searchCode = "D"
        }
        if type == "Civil Rights" {
            searchCode = "R"
        }
        if type == "Community Improvement" {
            searchCode = "S"
        }
        if type == "Disaster Relief" {
            searchCode = "M"
        }
        if type == "Education" {
            searchCode = "B"
        }
        if type == "Environmental" {
            searchCode = "C"
        }
        if type == "Housing & Shelter" {
            searchCode = "L"
        }
        if type == "Human Services" {
            searchCode = "P"
        }
        if type == "Mental Health" {
            searchCode = "F"
        }
        if type == "Nutrition" {
            searchCode = "K"
        }
        if type == "Philanthropy & Voluntarism" {
            searchCode = "T"
        }
        if type == "Public Society" {
            searchCode = "W"
        }
        if type == "Youth Development" {
            searchCode = "O"
        }
        
        if searchCode == " " {
            searchCode = "A"
        }
        
        charityPost.fetchLocalCharitiesWithCategory(state: state!, city: city!, category: searchCode) { result in
            switch result {
            case let .success(array) :
                
                OperationQueue.main.addOperation {
                    
                self.charities = array
                
                if self.charities == [] {
                    self.displayMyAlertMessage(userMessage: "No Results Found")
                }
                
                let charityResultsVC = self.storyboard!.instantiateViewController(withIdentifier: "CharityResultsView") as! CharityResultsTableViewController
                
                charityResultsVC.charities = self.charities
                
                self.navigationController?.pushViewController(charityResultsVC, animated:
                    true)
                    
                    return
                }
                
            case let .failure(error) :
                print("failed to get charities: \(error)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Charity Search"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
        typePicker.delegate = self
        typePicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func displayMyAlertMessage(userMessage: String) {
        
        OperationQueue.main.addOperation {
            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            myAlert.addAction(action)
            
            self.present(myAlert, animated: true, completion: nil)
            
            return
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return types.count
    }
    
    // Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        return types[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        type = self.types[row]
        
    }

}
