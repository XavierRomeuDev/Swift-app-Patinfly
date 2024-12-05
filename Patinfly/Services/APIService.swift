//
//  APIService.swift
//  Patinfly
//
//  Created by Xavier Romeu on 27/9/22.
//

import Foundation

class APIService{
    
    static let shared = APIService()
    
    enum APIError: Error{
        case error
    }
    
    func validUser(credentials: Credentials) -> Bool{
        return (credentials.email == "xavier@urv.cat") && (credentials.password == "hola")
    }
    
    func login(credentials: Credentials, completition: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if self.validUser(credentials: credentials){
                completition(.success(true))
            }
            else{
                completition(.failure(.invalidCredentials))
            }
        }
    }
}
