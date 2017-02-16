//
//  EventPost.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


internal enum EventPostResult {
    case success([Event])
    case failureLogin(String)
    case failure(EventPost.Error)
}

class EventPost {
    
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        case system(Swift.Error)
    }
    
    func postRSVP(userId: Int, eventId: Int, completion: @escaping (EventPostResult) -> ()) {
        
        let session = URLSession.shared
        
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: . rsvpEvent)
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        
        
        let payload = try! JSONSerialization.data(withJSONObject: ["userId": userId, "eventId": eventId], options: [])
        request.httpBody = payload
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            
            if let data = optionalData {
                print(data)
                completion(self.processPostRSVP(data: data, error: optionalError))
                
                
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
    
    func processPostRSVP(data: Data, error: Swift.Error?) -> EventPostResult {
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            
            if let eventArray = Event.array(from: object["events"] as! [[String: Any]]) {
                return .success(eventArray)
            } else {
                return .failureLogin(object["errorInfomation"] as! String)
            }
        }
        return .failure(.system(error!))
    }
    
    
    
    //Your Events
    //Your Host Events
    //Create Event
    //Edit Event
    //Delete Event
    
    
}
