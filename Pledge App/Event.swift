//
//  Event.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//
import UIKit
import Foundation

class Event : Equatable {
    public static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.name == rhs.name && lhs.host == rhs.host && lhs.hostId == rhs.hostId && lhs.address == rhs.address && lhs.city == rhs.city && lhs.state == rhs.state && lhs.zip == rhs.zip && lhs.eventId == rhs.eventId && lhs.location == rhs.location && lhs.startTime == rhs.startTime && lhs.endTime == rhs.endTime && lhs.details == rhs.details && lhs.type == rhs.type && lhs.userIds == rhs.userIds
    }
    
    var name: String
    var host: String
    let hostId: String
    let eventId: String
    var location: String
    var address: String
    var city: String
    var state: String
    var zip: Int
    var startTime: TimeInterval
    var endTime: TimeInterval
    var details: String
    var type: String
    var userIds: [String]
    
    
    init(name: String, host: String, hostId: String, eventId: String, location: String, address: String, city: String, state: String, zip: Int, startTime: TimeInterval, endTime: TimeInterval, details: String, type: String, userIds: [String]) {
        self.name = name
        self.host = host
        self.hostId = hostId
        self.eventId = eventId
        
        self.location = location
        self.address = address
        self.city = city
        self.state = state
        self.zip = zip
        self.startTime = startTime
        self.endTime = endTime
        self.details = details
        self.type = type
        self.userIds = userIds
        
    }
    
    convenience init?(jsonObject: [String: Any]) {
        
        
        guard let eventName = jsonObject["name"] as? String,
            let eventHost = jsonObject["host"] as? String,
            let eventLocation = jsonObject["location"] as? String,
            let eventAddress = jsonObject["address"] as? String,
            let eventCity = jsonObject["city"] as? String,
            let eventState = jsonObject["state"] as? String,
            let eventZip = jsonObject["zip"] as? Int,
            let eventDetails = jsonObject["details"] as? String,
            let eventHostID = jsonObject["hostId"] as? String,
            let eventID = jsonObject["id"] as? String,
            let eventType = jsonObject["type"] as? String,
            let eventStart = jsonObject["startTime"] as? TimeInterval,
            let eventEnd = jsonObject["endTime"] as? TimeInterval,
            let eventUserIds = jsonObject["userIds"] as? [String] else {
                
                return nil
                
        }
        
       
        self.init(name: eventName, host: eventHost, hostId: eventHostID, eventId: eventID, location: eventLocation, address: eventAddress, city: eventCity, state: eventState, zip: eventZip, startTime: eventStart, endTime: eventEnd, details: eventDetails, type: eventType, userIds: eventUserIds)
    }
}

extension Event {
    internal static func array(from jsonObjects: [[String: Any]]) -> [Event]? {
        let eventArray = jsonObjects.flatMap(Event.init(jsonObject:))
        
        
        return eventArray
    }
}
