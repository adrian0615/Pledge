//
//  Individual.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


class Individual : Equatable {
    public static func == (lhs: Individual, rhs: Individual) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName && lhs.email == rhs.email && lhs.userId == rhs.userId
    }
    
    var firstName: String
    var lastName: String
    var email: String
    var userId: String
    
    
    
    
    init(firstName: String, lastName: String, email: String, userId: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.userId = userId
    }
    
    convenience init?(jsonObject: [String: Any]) {
        //May have to adjust if not getting all items in return
        
        
        
        guard let userFirst = jsonObject["firstName"] as? String,
        let userLast = jsonObject["lastName"] as? String,
        let userEmail = jsonObject["email"] as? String,
        let theUserId = jsonObject["id"] as? String else {
                return nil
        }
       
        
        self.init(firstName: userFirst, lastName: userLast, email: userEmail, userId: theUserId)
        
    }
    
}
