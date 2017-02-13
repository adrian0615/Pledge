//
//  EventTests.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import XCTest
@testable import Pledge_App
class EventTests: XCTestCase {
    
    func testGetEventInfoSuccess() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 123, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailName() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 123, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Testy", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailHost() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson1", "hostId": 321, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailHostID() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 1234, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    
    
    func testGetEventInfoFailEventID() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 123, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 321, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailLocation() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 123, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "Location", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailAddress() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test", "host": "TestPerson", "hostId": 123, "eventId": 123, "photo": imageData.base64EncodedString(), "location": "TestLocation", "address": "TestAddress", "city": "TestCity", "state": "TestState", "zip": 12345, "startTime": 147410000000, "endTime": 147410000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test", host: "TestPerson", hostId: 123, eventId: 123, photo: image, location: "TestLocation", address: "TestAddress1", city: "TestCity", state: "TestState", zip: 12345, startTime: 147410000000, endTime: 147410000000, details: "TestDetails", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoSuccess2() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocation1", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertEqual(event, expected)
        
        
    }
    
    
    
    func testGetEventInfoFailCity() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailState() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState", "zip": 54321, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailZip() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54323, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailStartTime() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147413000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailEndTime() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147412000000, "endTime": 147411000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailDetails() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocatio1n", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
    func testGetEventInfoFailType() {
        
        let _fileName = "pledge-logo"
        
        guard let image = UIImage(named: _fileName), let imageData = UIImageJPEGRepresentation(image, 1.0) else {
            
            fatalError()
        }
        
        let sample: [String: Any] = ["name":"Test1", "host": "TestPerson1", "hostId": 321, "eventId": 321, "photo": imageData.base64EncodedString(), "location": "TestLocation1", "address": "TestAddress1", "city": "TestCity1", "state": "TestState1", "zip": 54321, "startTime": 147412000000, "endTime": 147412000000, "details": "TestDetails1", "type": "TestType"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample, options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Event.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Event.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let event = Event(jsonObject: jsonObject)!
        
        
        let expected = Event(name: "Test1", host: "TestPerson1", hostId: 321, eventId: 321, photo: image, location: "TestLocation1", address: "TestAddress1", city: "TestCity1", state: "TestState1", zip: 54321, startTime: 147412000000, endTime: 147412000000, details: "TestDetails1", type: "TestType1")
        
        XCTAssertNotEqual(event, expected)
        
        
    }
    
}
