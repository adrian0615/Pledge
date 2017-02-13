//
//  CharityTests.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import XCTest
@testable import Pledge_App
class CharityTests: XCTestCase {
    
    func testGetCharitySuccess() {
        
        let sample: [String: Any] = ["charityName": "Test1", "category": "Test2", "city": "Test3", "state": "Test4", "zipCode": "Test5", "missionStatement": "Test6", "donationUrl": "Test7"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test1", category: "Test2", city: "Test3", state: "Test4", zip: "Test5", description: "Test6", donate: "Test7")
        
        XCTAssertEqual(charity, expected)
    }
    
    func testGetCharityFailName() {
        
        let sample: [String: Any] = ["charityName": "Test", "category": "Test2", "city": "Test3", "state": "Test4", "zipCode": "Test5", "missionStatement": "Test6", "donationUrl": "Test7"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test1", category: "Test2", city: "Test3", state: "Test4", zip: "Test5", description: "Test6", donate: "Test7")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    func testGetCharityFailCategory() {
        
        let sample: [String: Any] = ["charityName": "Test1", "category": "test2", "city": "Test3", "state": "Test4", "zipCode": "Test5", "missionStatement": "Test6", "donationUrl": "Test7"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test1", category: "Test2", city: "Test3", state: "Test4", zip: "Test5", description: "Test6", donate: "Test7")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    func testGetCharityFailCity() {
        
        let sample: [String: Any] = ["charityName": "Test1", "category": "Test2", "city": "Test3", "state": "Test4", "zipCode": "Test5", "missionStatement": "Test6", "donationUrl": "Test7"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test1", category: "Test2", city: "Atlanta", state: "Test4", zip: "Test5", description: "Test6", donate: "Test7")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    func testGetCharityFailState() {
        
        let sample: [String: Any] = ["charityName": "Test1", "category": "Test2", "city": "Test3", "state": "TESt4", "zipCode": "Test5", "missionStatement": "Test6", "donationUrl": "Test7"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test1", category: "Test2", city: "Test3", state: "Test4", zip: "Test5", description: "Test6", donate: "Test7")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    
    func testGetCharitySuccess2() {
        
        let sample: [String: Any] = ["charityName": "Test8", "category": "Test9", "city": "Test10", "state": "Test11", "zipCode": "Test12", "missionStatement": "Test13", "donationUrl": "Test14"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test8", category: "Test9", city: "Test10", state: "Test11", zip: "Test12", description: "Test13", donate: "Test14")
        
        XCTAssertEqual(charity, expected)
    }
    
    func testGetCharityFailZip() {
        
        let sample: [String: Any] = ["charityName": "Test8", "category": "Test9", "city": "Test10", "state": "Test11", "zipCode": "12345", "missionStatement": "Test13", "donationUrl": "Test14"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test8", category: "Test9", city: "Test10", state: "Test11", zip: "Test12", description: "Test13", donate: "Test14")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    func testGetCharityFailDescription() {
        
        let sample: [String: Any] = ["charityName": "Test8", "category": "Test9", "city": "Test10", "state": "Test11", "zipCode": "Test12", "missionStatement": "Test13", "donationUrl": "Test14"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test8", category: "Test9", city: "Test10", state: "Test11", zip: "Test12", description: "missionStatement", donate: "Test14")
        
        XCTAssertNotEqual(charity, expected)
    }
    
    func testGetCharityFailDonation() {
        
        let sample: [String: Any] = ["charityName": "Test8", "category": "Test9", "city": "Test10", "state": "Test11", "zipCode": "Test12", "missionStatement": "Test13", "donationUrl": "www"]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Charity.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Charity.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let charity = Charity(jsonObject: jsonObject)!
        
        let expected = Charity(name: "Test8", category: "Test9", city: "Test10", state: "Test11", zip: "Test12", description: "Test13", donate: "Test14")
        
        XCTAssertNotEqual(charity, expected)
    }
    
}
