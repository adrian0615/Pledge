//
//  IndividualTests.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import XCTest
@testable import Pledge_App
class IndividualTests: XCTestCase {
    
    func testGetIndividualInfoSuccess() {
        
        
        let sample: [String: Any] = ["firstName": "Test1", "lastName": "Test2", "email":"Test3", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test1", lastName: "Test2", email: "Test3", userId: 123, hostId: 123)
        
        XCTAssertEqual(individual, expected)
        
    }
    
    func testGetIndividualFailFirstName() {
        
        
        let sample: [String: Any] = ["firstName": "Test", "lastName": "Test2", "email":"Test3", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test1", lastName: "Test2", email: "Test3", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(individual, expected)
        
    }
    
    func testGetIndividualFailLastName() {
        
        
        let sample: [String: Any] = ["firstName": "Test1", "lastName": "Last", "email":"Test3", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test1", lastName: "Test2", email: "Test3", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(individual, expected)
        
    }
    
    func testGetIndividualFailEmail() {
        
        
        let sample: [String: Any] = ["firstName": "Test1", "lastName": "Test2", "email":"Test3", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test1", lastName: "Test2", email: "Test8", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(individual, expected)
        
    }
    
    func testGetIndividualInfoSuccess2() {
        
        
        let sample: [String: Any] = ["firstName": "Test5", "lastName": "Test6", "email":"Test7", "userId": 1234, "hostId": 1234]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test5", lastName: "Test6", email: "Test7", userId: 1234, hostId: 1234)
        
        XCTAssertEqual(individual, expected)
        
    }
    
    func testGetIndividualInfoFailUserID() {
        
        
        let sample: [String: Any] = ["firstName": "Test5", "lastName": "Test6", "email":"Test7", "userId": 12345, "hostId": 1234]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test5", lastName: "Test6", email: "Test7", userId: 123456, hostId: 1234)
        
        XCTAssertNotEqual(individual, expected)
        
    }
    
    func testGetIndividualInfoFailHostID() {
        
        
        let sample: [String: Any] = ["firstName": "Test5", "lastName": "Test6", "email":"Test7", "userId": 1234, "hostId": 1234]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Individual.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Individual.txt", encoding: .utf8)
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let individual = Individual(jsonObject: jsonObject)!
        
        let expected = Individual(firstName: "Test5", lastName: "Test6", email: "Test7", userId: 1234, hostId: 123456)
        
        XCTAssertNotEqual(individual, expected)
        
    }
 
}
