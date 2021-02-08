//
//  Launch.swift
//  Space
//
//  Created by Eric Granger on 06/02/2021.
//

import Foundation

struct Launch: Decodable {
    var id: String
    var flightNumber: Int
    var name: String
    var date: Date
    var links: Links
    var success: Bool?
    var details: String?
    var rocketId: String?
    
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
    var patch: Patch
    var flickr: Flickr
    var youtubeId: String?
    
    enum CodingKeys: String, CodingKey {
        case patch
        case flickr
        case youtubeId = "youtube_id"
    }
}

struct Patch: Decodable {
    var small: String?
}

struct Flickr: Decodable {
    var original: [String]
}
