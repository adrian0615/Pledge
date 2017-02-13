//
//  EventStore.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/10/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation

internal enum EventsResult {
    case success([Event])
    case failure(EventStore.Error)
}

class EventStore {
    
    enum Error: Swift.Error {
        case httpError(URLResponse)
        case system(Swift.Error)
        case pledgeAPI(PledgeAPI.Error)
    }
    
    
    func fetchUpcomingEvents(_ completion: @escaping (EventsResult) -> ()) {
        
        let url = PledgeAPI(base: PledgeAPI.baseURL).fullURL(method: .upcomingEvents)
        let task = URLSession.shared.dataTask(with: url) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                completion(self.processRecentEventsRequest(data: data, error: optionalError))
                
            } else if let response = optionalResponse {
                completion(.failure(Error.httpError(response)))
            } else {
                completion(.failure(optionalError! as! EventStore.Error))
            }
        }
        
        task.resume()
    }
    
    internal func processRecentEventsRequest(data: Data, error: Swift.Error?) -> EventsResult {
        
        if let events = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]] {
            if let eventArray = Event.array(from: events) {
                return .success(eventArray)
            } else {
                
                return .failure(.pledgeAPI(.invalidJSONData))
            }
        } else {
            
            return .failure(.system(error!))
        }
    }
    
    
}

