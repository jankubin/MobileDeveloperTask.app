//
//  LaunchesModel.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 05.08.2023.
//

import Foundation

struct Response: Hashable, Codable {
    let name: String
    let details: String?
    var dateLocal: String
    let flightNumber: Int
    let links: Links
    
}

struct Links: Hashable, Codable {
    let webcast: String?
    let wikipedia: String?
    let patch: Patch?
    
}

struct Patch: Hashable, Codable {
    let small: String?
    let large: String?
}
