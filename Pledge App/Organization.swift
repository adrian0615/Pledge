//
//  Organization.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


class Organization : Equatable {
    public static func == (lhs: Organization, rhs: Organization) -> Bool {
        return lhs.name == rhs.name && lhs.address == rhs.address && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.email == rhs.email && lhs.hostId == rhs.hostId && lhs.userId == rhs.userId
    }
    
    var name: String
    var address: String
    var city: String
    var state: String
    var zip: Int
    var hostId: Int
    var userId: Int
    var email: String
    
    
    init(name: String, address: String, city: String, state: String, zip: Int, email: String, userId: Int, hostId: Int) {
        
        self.name = name
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.email = email
        self.userId = userId
        self.hostId = hostId
        
    }
    
    convenience init?(jsonObject: [String: Any]) {
        //May have to adjust if not getting all items in return
        
        guard let userName = jsonObject["name"] as? String,
            let userAddress = jsonObject["address"] as? String,
            let userCity = jsonObject["city"] as? String,
            let userState = jsonObject["state"] as? String,
            let userZip = jsonObject["zip"] as? Int,
            let userEmail = jsonObject["email"] as? String,
            let userHostId = jsonObject["hostId"] as? Int,
            let theUserId = jsonObject["userId"] as? Int else {
                return nil
        }
        
        
        self.init(name: userName, address: userAddress, city: userCity, state: userState, zip: userZip, email: userEmail, userId: theUserId, hostId: userHostId)
    }
}
