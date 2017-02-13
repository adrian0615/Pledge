//
//  OrganizationTests.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/9/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import XCTest
@testable import Pledge_App
class OrganizationTests: XCTestCase {
    
    func testGetOrganizationInfoSuccess() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailName() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test5", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailAddress() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "TeSt2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailCity() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailState() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "GA", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    
    func testGetOrganizationInfoSuccess2() {
        
        let sample: [String: Any] = ["name": "Test7", "address": "Test8", "city": "Test9", "state": "Test10", "zip": 54321, "email":"Test11", "userId": 321, "hostId": 321]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test7", address: "Test8", city: "Test9", state: "Test10", zip: 54321, email: "Test11", userId: 321, hostId: 321)
        
        XCTAssertEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailZip() {
        
        let sample: [String: Any] = ["name": "Test7", "address": "Test8", "city": "Test9", "state": "Test10", "zip": 12345, "email":"Test11", "userId": 321, "hostId": 321]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test7", address: "Test8", city: "Test9", state: "Test10", zip: 54321, email: "Test11", userId: 321, hostId: 321)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailEmail() {
        
        let sample: [String: Any] = ["name": "Test7", "address": "Test8", "city": "Test9", "state": "Test10", "zip": 54321, "email":"Test11", "userId": 321, "hostId": 321]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test7", address: "Test8", city: "Test9", state: "Test10", zip: 54321, email: "Test55", userId: 321, hostId: 321)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    func testGetOrganizationInfoFailUserID() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 321, "hostId": 123]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
    
    func testGetOrganizationInfoFailHostID() {
        
        let sample: [String: Any] = ["name": "Test1", "address": "Test2", "city": "Test3", "state": "Test4", "zip": 12345, "email":"Test5", "userId": 123, "hostId": 555]
        
        let jsonRepresentation = try! JSONSerialization.data(withJSONObject: sample , options: [])
        
        let stringSample = String(bytes: jsonRepresentation, encoding: .utf8)!
        _ = try? stringSample.write(toFile: "/Users/AdrianHome/Organization.txt", atomically: true, encoding: .utf8)
        
        let returnedSample = try! String(contentsOfFile: "/Users/AdrianHome/Organization.txt", encoding: .utf8)
        
        let jsonData = returnedSample.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String: Any]
        
        let organization = Organization(jsonObject: jsonObject)!
        
        let expected = Organization(name: "Test1", address: "Test2", city: "Test3", state: "Test4", zip: 12345, email: "Test5", userId: 123, hostId: 123)
        
        XCTAssertNotEqual(organization, expected)
        
    }
    
}
