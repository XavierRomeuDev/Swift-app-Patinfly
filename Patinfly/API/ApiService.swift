//
//  ApiService.swift
//  Patinfly
//
//  Created by Xavier Romeu on 13/12/22.
//

import Foundation

class ApiService{
    
    static func checkServerStatusWithCompletion(completion: @escaping (Result<ServerStatus, NetworkError>) -> Void){
        let callURL = APIConstants.serverStatus()
        let task = URLSession.shared.dataTask(with:callURL.url!){data, response, error in
                    
            if let networkError = NetworkError(data: data, response: response, error: error) {
                        print("APIService: error accessing server status")
                        completion(.failure(networkError))
            }
            do {
                let status = try JSONDecoder().decode(ServerStatus.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(status))
                }
            } catch let errorParser{
                print("The data from server status is compliance with the specifications or server is not working")
                print(errorParser)
                completion(.failure(.decodingError(errorParser)))
            }
        }
        task.resume()
    }
    
    static func scooterListWithCompletion(withToken: String, completion: @escaping (Result<ScootersAPI, NetworkError>) -> Void){
        let callURL = APIConstants.scooters()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ScootersAPI.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
    static func scooterDataWithCompletion(withToken: String, scooterToken: String, completion: @escaping (Result<ScootersAPI, NetworkError>) -> Void){
        let callURL = APIConstants.scooterWithID(id: scooterToken)
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ScootersAPI.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
    static func scooterOnRent(withToken: String, completion: @escaping (Result<ScootersRent, NetworkError>) -> Void){
        let callURL = APIConstants.startScooterRent()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ScootersRent.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
    static func scooterEndRent(withToken: String, completion: @escaping (Result<ScootersRent, NetworkError>) -> Void){
        let callURL = APIConstants.endScooterRent()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(ScootersRent.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
        
    static func userRent(withToken: String, completion: @escaping (Result<UserRents, NetworkError>) -> Void){
        let callURL = APIConstants.userRents()
        
        var request = URLRequest(url: (callURL.url)!)
        request.httpMethod = "GET"
        
        request.setValue(withToken, forHTTPHeaderField: "api-key")
        
        let task = URLSession.shared.dataTask(with:request){
            data, response, error in
                        
                if let networkError = NetworkError(data: data, response: response, error: error) {
                            print("APIService: error accessing server status")
                            completion(.failure(networkError))
                }
                do {
                    let jsonData = try JSONDecoder().decode(UserRents.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let errorParser{
                    print("The data from server status is compliance with the specifications or server is not working")
                    print(errorParser)
                    completion(.failure(.decodingError(errorParser)))
                }
        }
        task.resume()
    }
    
}
