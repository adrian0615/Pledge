//
//  IndividualPost.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/8/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


internal enum IndividualPostResult {
    case success(Individual)
    case failureLogin(String)
    case failure(IndividualPost.Error)
}

class IndividualPost {
    
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        case system(Swift.Error)
    }
    
    
    func postLogin(email: String, password: String, completion: @escaping (IndividualPostResult) -> ()) {
        
        let session = URLSession.shared
        
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .individualLogin)
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
    
    func processPostLogin(data: Data, error: Swift.Error?) -> IndividualPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            if object["errorInfomation"] as? String == "Invalid email or password" {
                return .failureLogin(object["errorInfomation"] as! String)
            } else {
            if let individualDict = Individual.init(jsonObject: (object["individual"] as! [String: Any])) {
            return .success(individualDict)
                }
            }
        }
            return .failure(.system(error!))
    }
    
    func postRegister(firstName: String, lastName: String, email: String, password: String, completion: @escaping (IndividualPostResult) -> ()) {
        
        let session = URLSession.shared
        
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .individualRegistration)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["firstName": firstName, "lastName": lastName, "email": email, "password": password], options: [])
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
    
    func processPostRegister(data: Data, error: Swift.Error?) -> IndividualPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            if object["errorInfomation"] as? String == "Invalid email or password" {
                return .failureLogin(object["errorInfomation"] as! String)
            } else {
                if let individualDict = Individual.init(jsonObject: (object["individual"] as! [String: Any])) {
                    return .success(individualDict)
                }
            }
        }
        return .failure(.system(error!))
    }
    
    func postEditProfile(firstName: String, lastName: String, email: String, userId: String, completion: @escaping (IndividualPostResult) -> ()) {
        
        let session = URLSession.shared
        //Need URL String*********************************************
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .individualRegistration)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["firstName": firstName, "lastName": lastName, "email": email, "id": userId], options: [])
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
    
    func processPostProfile(data: Data, error: Swift.Error?) -> IndividualPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            if object["errorInfomation"] as? String == "Invalid email or password" {
                return .failureLogin(object["errorInfomation"] as! String)
            } else {
                if let individualDict = Individual.init(jsonObject: (object["individual"] as! [String: Any])) {
                    return .success(individualDict)
                }
            }
        }
        return .failure(.system(error!))
    }
        
}
