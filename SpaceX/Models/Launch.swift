//
//  Launch.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import Foundation

struct Launch: Decodable {
    let id: String
    let flightNumber: Int
    let name: String
    let date: Date
    let links: Links
    let success: Bool?
    let details: String?
    let rocketId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case flightNumber = "flight_number"
        case name
        case date = "date_utc"
        case links
        case success
        case details
        case rocketId = "rocket"
    }
}

struct Links: Decodable {
    let patch: Patch
    let flickr: Flickr
    let youtubeId: String?
    
    enum CodingKeys: String, CodingKey {
        case patch
        case flickr
        case youtubeId = "youtube_id"
    }
}

struct Patch: Decodable {
    let small: String?
}

struct Flickr: Decodable {
    let original: [String]
}




