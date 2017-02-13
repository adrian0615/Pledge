//
//  OrganizationPost.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/8/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


internal enum OrganizationPostResult {
    case success(Organization)
    case failure(OrganizationPost.Error)
}

class OrganizationPost {
    
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        case system(Swift.Error)
    }
    
    
    func postLogin(email: String, password: String, completion: @escaping (OrganizationPostResult) -> ()) {
        
        let session = URLSession.shared
        //Need URL String**************************************************
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .organizationLogin)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["email": email, "password": password], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                print(data)
                completion(self.processPostLogin(data: data, error: optionalError))
                
                
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                
                print("optionalResponse: \(optionalResponse)")
                
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    func processPostLogin(data: Data, error: Swift.Error?) -> OrganizationPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            print(object)
            if let organizationDict = Organization.init(jsonObject: (object["individual"] as! [String: Any])) {
                return .success(organizationDict)
            } else {
                return .failure(.system(error!))
                
            }
        }
        return .failure(.system(error!))
    }
    
    func postRegister(name: String, address: String, city: String, state: String, zip: Int, email: String, password: String, completion: @escaping (OrganizationPostResult) -> ()) {
        
        let session = URLSession.shared
        //Need URL String
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .organizationRegistration)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["name": name, "address": address, "city": city, "state": state, "zip": zip, "email": email, "password": password], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                print(data)
                completion(self.processPostRegister(data: data, error: optionalError))
                
                
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                
                print("optionalResponse: \(optionalResponse)")
                
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    func processPostRegister(data: Data, error: Swift.Error?) -> OrganizationPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            print(object)
            if let organizationDict = Organization.init(jsonObject: (object["individual"] as! [String: Any])) {
                return .success(organizationDict)
            } else {
                return .failure(.system(error!))
                
            }
        }
        return .failure(.system(error!))
    }
    
    func postProfile(name: String, address: String, city: String, state: String, zip: Int, email: String, userId: Int, completion: @escaping (OrganizationPostResult) -> ()) {
        
        let session = URLSession.shared
        //Need URL String*********************************************
        let url = URL(string: "https://")!
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["name": name, "address": address, "city": city, "state": state, "zip": zip, "email": email, "userId": userId], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                print(data)
                completion(self.processPostProfile(data: data, error: optionalError))
                
                
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
                
                
                print("optionalResponse: \(optionalResponse)")
                
            } else {
                completion(.failure(.system(optionalError!)))
            }
        }
        task.resume()
    }
    
    func processPostProfile(data: Data, error: Swift.Error?) -> OrganizationPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            print(object)
            if let organizationDict = Organization.init(jsonObject: (object["individual"] as! [String: Any])) {
                return .success(organizationDict)
            } else {
                return .failure(.system(error!))
                
            }
        }
        return .failure(.system(error!))
    }
}
