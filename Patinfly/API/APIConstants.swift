//
//  APIConstants.swift
//  Patinfly
//
//  Created by Xavier Romeu on 13/12/22.
//

import Foundation

struct APIConstants{
    static let scheme = "https"
    static let host = "patinfly.com"
    static let token: String = "i6zwGJX1qThnE8L7Hk2ycIptQO9jCrfxPaYgo3VR"
    static let scooterUUID: String = "cabdbd82-cf15-11ec-9d64-0242ac120002"
    static let urlServer: String = "https://patinfly.com/"
    static let pathStatus: String = "/endpoints/status/"
    static let pathScooter: String = "/endpoints/scooter/"
    static let pathStartScooterRent: String = "/endpoints/rent/start/cabdbd82-cf15-11ec-9d64-0242ac120002"
    static let pathEndScooterRent: String = "/endpoints/rent/stop/cabdbd82-cf15-11ec-9d64-0242ac120002"
    static let pathUserRents: String = "/endpoints/rent"
    
    static func baseURL() -> URLComponents{
        var baseServerURL: URLComponents = URLComponents()
        baseServerURL.scheme = APIConstants.scheme
        baseServerURL.host = APIConstants.host
        return baseServerURL
    }
    
    static func serverStatus() -> URLComponents{
        var urlServerStatus: URLComponents = APIConstants.baseURL()
        urlServerStatus.path = APIConstants.pathStatus
        return urlServerStatus
    }
    
    static func scooters() -> URLComponents{
        var urlServerScooters: URLComponents = APIConstants.baseURL()
        urlServerScooters.path = APIConstants.pathScooter
        return urlServerScooters
    }
    
    //on func call use the uuid to fetch the data
    static func scooterWithID(id: String) -> URLComponents{
        var urlServerScooterInfo: URLComponents = APIConstants.baseURL()
        urlServerScooterInfo.path = APIConstants.pathScooter + id
        return urlServerScooterInfo
    }
    
    static func startScooterRent() -> URLComponents{
        var urlServerScooterStartRent: URLComponents = APIConstants.baseURL()
        urlServerScooterStartRent.path = APIConstants.pathStartScooterRent
        return urlServerScooterStartRent
    }
    
    static func endScooterRent() -> URLComponents{
        var urlServerScooterEndRent: URLComponents = APIConstants.baseURL()
        urlServerScooterEndRent.path = APIConstants.pathEndScooterRent
        return urlServerScooterEndRent
    }
    
    static func userRents() -> URLComponents{
        var urlServerScooterEndRent: URLComponents = APIConstants.baseURL()
        urlServerScooterEndRent.path = APIConstants.pathUserRents
        return urlServerScooterEndRent
    }
}
