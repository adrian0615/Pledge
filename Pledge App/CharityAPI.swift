//
//  CharityAPI.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/6/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import Foundation

struct CharityAPI {
    internal enum Error: Swift.Error {
        case invalidJSONData
    }
    
    static var baseURL: URL { return URL(string: "http://data.orghunter.com/v1/charitysearch?user_key=1ef02fef452ef1393eb140832ca55c15")! }
    let base: URL
    
    init(base: URL) {
        self.base = base
    }
    
    enum CharityType {
        case civilRights
        case communityImprovement
        case youthDevelopment
        case artsCultureHumanities
        case education
        case animal
        case environment
        case mentalHealth
        case nutrition
        case housing
        case disasterRelief
        case humanServices
        case philanthropyVoluntarism
        case publicSociety
        
        var makeString: String? {
            switch self {
            case .civilRights:
                return "&category=R"
            case .communityImprovement:
                return "&category=S"
            case .youthDevelopment:
                return "&category=O"
            case .artsCultureHumanities:
                return "&category=A"
            case .education:
                return "&category=B"
            case .animal:
                return "&category=D"
            case .environment:
                return "&category=C"
            case .mentalHealth:
                return "&category=F"
            case .nutrition:
                return "&category=K"
            case .housing:
                return "&category=L"
            case .disasterRelief:
                return "&category=M"
            case .humanServices:
                return "&category=P"
            case .philanthropyVoluntarism:
                return "&category=T"
            case .publicSociety:
                return "&category=W"
            }
        }
    }
    
    enum Method {
        case AK
        case AL
        case AR
        case AZ
        case CA
        case CO
        case CT
        case DC
        case DE
        case FL
        case GA
        case HI
        case IA
        case ID
        case IL
        case IN
        case KY
        case KS
        case LA
        case LV
        case MA
        case MD
        case ME
        case MI
        case MN
        case MO
        case MS
        case MT
        case NC
        case NE
        case NJ
        case ND
        case NH
        case NM
        case NY
        case OH
        case OK
        case OR
        case PA
        case RI
        case SC
        case SD
        case TN
        case TX
        case UT
        case VA
        case VT
        case WA
        case WI
        case WV
        case WY
        case civilRights
        case communityImprovement
        case youthDevelopment
        case artsCultureHumanities
        case education
        case animal
        case environment
        case mentalHealth
        case nutrition
        case housing
        case disasterRelief
        case humanServices
        case philanthropyVoluntarism
        case publicSociety
        
        var urlPathComponent: String {
            switch self {
            case .AK:
                return "&state=AK"
            case .AL:
                return "&state=AL"
            case .AR:
                return "&state=AR"
            case .AZ:
                return "&state=AZ"
            case .CA:
                return "&state=CA"
            case .CO:
                return "&state=CO"
            case .CT:
                return "&state=CT"
            case .DC:
                return "&state=DC"
            case .DE:
                return "&state=DE"
            case .FL:
                return "&state=FL"
            case .GA:
                return "&state=GA"
            case .HI:
                return "&state=HI"
            case .IA:
                return "&state=IA"
            case .ID:
                return "&state=ID"
            case .IL:
                return "&state=IL"
            case .IN:
                return "&state=IN"
            case .KY:
                return "&state=KY"
            case .KS:
                return "&state=KS"
            case .LA:
                return "&state=LA"
            case .LV:
                return "&state=LV"
            case .MA:
                return "&state=MA"
            case .MD:
                return "&state=MD"
            case .ME:
                return "&state=ME"
            case .MI:
                return "&state=MI"
            case .MN:
                return "&state=MN"
            case .MO:
                return "&state=MO"
            case .MS:
                return "&state=MS"
            case .MT:
                return "&state=MT"
            case .NC:
                return "&state=NC"
            case .NE:
                return "&state=NE"
            case .NJ:
                return "&state=NJ"
            case .ND:
                return "&state=ND"
            case .NH:
                return "&state=NH"
            case .NM:
                return "&state=NM"
            case .NY:
                return "&state=NY"
            case .OH:
                return "&state=OH"
            case .OK:
                return "&state=OK"
            case .OR:
                return "&state=OR"
            case .PA:
                return "&state=PA"
            case .RI:
                return "&state=RI"
            case .SC:
                return "&state=SC"
            case .SD:
                return "&state=SD"
            case .TN:
                return "&state=TN"
            case .TX:
                return "&state=TX"
            case .UT:
                return "&state=UT"
            case .VA:
                return "&state=VA"
            case .VT:
                return "&state=VT"
            case .WA:
                return "&state=WA"
            case .WI:
                return "&state=WI"
            case .WV:
                return "&state=WV"
            case .WY:
                return "&state=WY"
            case .civilRights:
                return "&category=R"
            case .communityImprovement:
                return "&category=S"
            case .youthDevelopment:
                return "&category=O"
            case .artsCultureHumanities:
                return "&category=A"
            case .education:
                return "&category=B"
            case .animal:
                return "&category=D"
            case .environment:
                return "&category=C"
            case .mentalHealth:
                return "&category=F"
            case .nutrition:
                return "&category=K"
            case .housing:
                return "&category=L"
            case .disasterRelief:
                return "&category=M"
            case .humanServices:
                return "&category=P"
            case .philanthropyVoluntarism:
                return "&category=T"
            case .publicSociety:
                return "&category=W"
            }
        }
    }
    
    
    
    func fullURL(method: Method) -> URL {
        return base.appendingPathComponent(method.urlPathComponent)
    }
}

