//
//  Charity.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


class Charity: Equatable {
    public static func == (lhs: Charity, rhs: Charity) -> Bool {
        return lhs.name == rhs.name && lhs.category == rhs.category && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.description == rhs.description && lhs.donate == rhs.donate
    }
    
    let name: String
    let category: String
    let city: String
    let state: String
    let zip: String
    let description: String
    let donate: String
    
    
    init(name: String, category: String, city: String, state: String, zip: String, description: String, donate: String) {
        self.name = name
        self.category = category
        self.city = city
        self.state = state
        self.zip = zip
        self.description = description
        self.donate = donate
    }
    
    convenience init?(jsonObject: [String: Any]) {
        //May have to adjust if not getting all items in return
        
        guard let charityName = jsonObject["charityName"] as? String,
            let charityCategory = jsonObject["category"] as? String,
            let charityCity = jsonObject["city"] as? String,
            let charityState = jsonObject["state"] as? String,
            let charityZip = jsonObject["zipCode"] as? String,
            let charityDescription = jsonObject["missionStatement"] as? String,
            let charityDonate = jsonObject["donationUrl"] as? String else {
                return nil
        }
        
        
        self.init(name: charityName, category: charityCategory, city: charityCity, state: charityState, zip: charityZip, description: charityDescription, donate: charityDonate)
    }
}

extension Charity {
    internal static func array(from jsonObjects: [[String: Any]]) -> [Charity]? {
        let charityArray = jsonObjects.flatMap(Charity.init(jsonObject:))
        
        
        return charityArray
    }
}

