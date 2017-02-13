//
//  PledgeAPI.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation


struct PledgeAPI {
    
    internal enum Error: Swift.Error {
        case invalidJSONData
    }
    
    static var baseURL: URL { return URL(string: "https://tiy-adrian-pledge.herokuapp.com/")! }
    let base: URL
    
    init(base: URL) {
        self.base = base
    }
    
    enum Method {
        case individualLogin
        case organizationLogin
        case individualRegistration
        case organizationRegistration
        case individualProfile
        case organizationProfile
        case upcomingEvents
        
        var urlPathComponent: String {
            switch self {
            case .individualLogin:
                return "login-individual.json"
                
            case .organizationLogin:
                return "login-organization.json"
                
            case .individualRegistration:
                return "register-individual.json"
                
            case .organizationRegistration:
                return "register-organization.json"
                
            case .individualProfile:
                return "profile-individual.json"
                
            case .organizationProfile:
                return "profile-organization.json"
                
            case .upcomingEvents:
                return "event-list.json"
            }
        }
        
        }
    
    
    func fullURL(method: Method) -> URL {
        return base.appendingPathComponent(method.urlPathComponent)
    }
}
