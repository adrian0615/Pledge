//
//  Fundraiser.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


class Fundraiser {
    public static func == (lhs: Fundraiser, rhs: Fundraiser) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.start == rhs.start && lhs.end == rhs.end && lhs.coordinates == rhs.coordinates
    }
    //Need to Fix Dates
    
    let title: String
    let description: String
    let start: String
    let end: String
    let coordinates: [Double]
    
    init(title: String, description: String, start: String, end: String, coordinates: [Double]) {
        self.title = title
        self.description = description
        self.start = start
        self.end = end
        self.coordinates = coordinates
    }
    
    convenience init?(jsonObject: [String: Any]) {
        guard let fundTitle = jsonObject["title"] as? String,
        let fundDescription = jsonObject["description"] as? String,
        let fundStart = jsonObject["start"] as? String,
            let fundEnd = jsonObject["end"] as? String,
        let fundCoordinates = jsonObject["location"] as? [Double] else {
                return nil
        }
        
        self.init(title: fundTitle, description: fundDescription, start: fundStart, end: fundEnd, coordinates: fundCoordinates)
    }
    
}

extension Fundraiser {
    internal static func array(from jsonObjects: [[String: Any]]) -> [Fundraiser]? {
        let fundArray = jsonObjects.flatMap(Fundraiser.init(jsonObject:))
        
        
        return fundArray
    }
}
