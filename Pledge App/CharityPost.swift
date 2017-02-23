//
//  CharityPost.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/8/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation




//KeyWord Search
//City Search
//State Search
//Zip Search
//Charity Type Search

internal enum CharityResult {
    case success([Charity])
    case failure(CharityPost.Error)
}


class CharityPost {
    enum Error: Swift.Error {
        case httpError(URLResponse)
        case system(Swift.Error)
        case charityAPI(CharityAPI.Error)
    }
    
    
    func fetchLocalCharities(state: String, city: String, completion: @escaping (CharityResult) -> ()) {
        
        let url = URL(string: "http://data.orghunter.com/v1/charitysearch?user_key=1ef02fef452ef1393eb140832ca55c15&state=\(state)&city=\(city)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                
                completion(self.processCharitiesRequest(data: data, error: optionalError))
                
            } else if let response = optionalResponse {
                completion(.failure(Error.httpError(response)))
            } else {
                completion(.failure(optionalError! as! CharityPost.Error))
            }
        }
        
        task.resume()
    }
    
    func fetchLocalCharitiesWithCategory(state: String, city: String, category: String, completion: @escaping (CharityResult) -> ()) {
        
        let url = URL(string: "http://data.orghunter.com/v1/charitysearch?user_key=1ef02fef452ef1393eb140832ca55c15&state=\(state)&city=\(city)&category=\(category)")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                
                completion(self.processCharitiesRequest(data: data, error: optionalError))
                
            } else if let response = optionalResponse {
                completion(.failure(Error.httpError(response)))
            } else {
                completion(.failure(optionalError! as! CharityPost.Error))
            }
        }
        
        task.resume()
    }
    
    internal func processCharitiesRequest(data: Data, error: Swift.Error?) -> CharityResult {
        
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            let charities = object["data"] 
            if let charityArray = Charity.array(from: charities as! [[String : Any]]) {
                return .success(charityArray)
            } else {
                
                return .failure(.charityAPI(.invalidJSONData))
            }
        } else {
            
            return .failure(.system(error!))
        }
    }
    
    
    
}
