//
//  FundraiserStore.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/14/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


internal enum FundraiserResult {
    case success([Fundraiser])
    case failure(FundraiserStore.Error)
}


class FundraiserStore {
    enum Error: Swift.Error {
        case httpError(URLResponse)
        case system(Swift.Error)
        case pledgeAPI(PledgeAPI.Error)
}
    
    func fetchLocalFundraisers(_ completion: @escaping (FundraiserResult) -> ()) {
        
        let url = URL(string: "https://api.predicthq.com/v1/events/?within=150km@33.7523938,-84.3915388&label=fundraiser&start.gte=2017-02-24&sort=start")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        
        
        request.setValue("Bearer VOLziM8DtI8b68zkzxthazD72wIbab", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                
                completion(self.processFundraiserRequest(data: data, error: optionalError))
                
            } else if let response = optionalResponse {
                completion(.failure(Error.httpError(response)))
            } else {
                completion(.failure(optionalError! as! FundraiserStore.Error))
            }
        }
        
        task.resume()
    }
    
    internal func processFundraiserRequest(data: Data, error: Swift.Error?) -> FundraiserResult {
        
        if let object = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
            let fundraisers = object["results"]
            if let fundArray = Fundraiser.array(from: fundraisers as! [[String : Any]]) {
                return .success(fundArray)
            } else {
                
                return .failure(.pledgeAPI(.invalidJSONData))
            }
        } else {
            
            return .failure(.system(error!))
        }
    }
    
    
    
}
