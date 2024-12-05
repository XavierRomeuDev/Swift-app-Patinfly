//
//  Scooters.swift
//  Patinfly
//
//  Created by Xavier Romeu on 4/10/22.
//

import Foundation
import MapKit
import SwiftUI

struct ScooterAPI: Codable {
    let id: Int = 1
    let uuid: String
    let name: String
    let longitude: Double
    let latitude: Double
    let battery_level: Float
    let km_use: Float
    let date_last_maintenance: String?
    let state: String
    let on_rent: Bool
}

struct ScootersAPI: Codable{
    let id: Int = 1
    let scooters: [ScooterAPI]
}

struct ScooterRent: Codable{
    let uuid: String?
    let date_start: String?
}

struct ScootersRent: Codable{
    let code: Int
    let msg: String
    let rent: ScooterRent
    let timestamp: String
    let version: Float = 1.0
}

struct UserRents: Codable{
    let rents: [UserRent]
}

struct UserRent: Codable{
    let uuid: String
    let scooter: ScooterAPI
    let date_start: String
    let date_stop: String?
}


func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> String
{
    
    let p1 = CLLocation(latitude: lat1, longitude: lon1)
    let p2 = CLLocation(latitude: lat2, longitude: lon2)
    
    let distancia = p1.distance(from: p2)
    let distance = Int(distancia)
    let finalDistance = String(distance)
    return finalDistance
    
}

func printBatteryIcon(battery: Float) -> some View
{
    if (battery > 89){
        return Image(systemName: "battery.100").foregroundColor(.green)
    }
    
    if (battery > 69 && battery < 89){
        return Image(systemName: "battery.75").foregroundColor(.green)
    }
    
    if (battery > 49 && battery < 68){
        return Image(systemName: "battery.50").foregroundColor(.green)
    }
    
    if (battery > 25 && battery < 48){
        return Image(systemName: "battery.25").foregroundColor(.orange)
    }
    
    if (battery < 11){
        return Image(systemName: "battery.0").foregroundColor(.red)
    }
    return Image(systemName: "battery.0").foregroundColor(.red)
}
    


func printScooter(state: String, on_rent: Bool) -> some View
{
    if (state == "ACTIVE" && on_rent == false) {
        return Image(systemName: "scooter").foregroundColor(.green)
    } else{
        return Image(systemName: "scooter").foregroundColor(.red)
    }
}

func dateFormat(date: String) -> String
{
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let result = dateFormatter.date(from: date)

    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateFormatted = dateFormatter.string(from: result!)
    
    return dateFormatted
}

