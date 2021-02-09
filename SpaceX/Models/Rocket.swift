//
//  Rocket.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import Foundation

struct Rocket: Decodable {
    let id: String
    let name: String
    let height: Height
    let mass: Mass
    let images: [String]
    let description: String
    
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
    let meters: Float
}

struct Mass: Decodable {
    let kg: Float
}

