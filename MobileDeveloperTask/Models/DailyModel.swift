//
//  DailyModel.swift
//  MobileDeveloperTask
//
//  Created by Jan Kubín on 06.08.2023.
//

import Foundation

struct Daily: Codable {
    let title: String?
    let explanation: String?
    let hdurl: String?
    let url: String?
    let copyright: String?
    var date: String?
}

enum DailyError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
