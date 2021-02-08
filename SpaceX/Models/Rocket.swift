//
//  Rocket.swift
//  Space
//
//  Created by Eric Granger on 07/02/2021.
//

import Foundation

struct Rocket: Decodable {
    var id: String
    var name: String
    var height: Height
    var mass: Mass
    var images: [String]
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case mass
        case images = "flickr_images"
        case description
    }
}

struct Height: Decodable {
    var meters: Float
}

struct Mass: Decodable {
    var kg: Float
}

