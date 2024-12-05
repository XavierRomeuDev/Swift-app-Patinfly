//
//  Status.swift
//  Patinfly
//
//  Created by Xavier Romeu on 13/12/22.
//

import Foundation

struct Status: Codable{
    let id:Int = 1
    let version: Int
    let build: Int
    let update: String
    let name: String
}

struct ServerStatus: Codable{
    let id:Int = 1
    let status: Status
}

