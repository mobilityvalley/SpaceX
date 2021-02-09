//
//  Seeds.swift
//  SpaceXTests
//
//  Created by Eric Granger on 09/02/2021.
//

@testable import SpaceX
import XCTest

struct Seeds
{
  struct Launches
  {
    static let patch = Patch(small: "http://abcd")
    static let flickr = Flickr(original: ["https://image1", "https://image2"])
    static let links = Links(patch: patch, flickr: flickr, youtubeId: "aaaddbbcbc")
    
    static let falcon = Launch(id: "abcd", flightNumber: 1, name: "Falcon 1", date: Date(), links: links, success: true, details: "this is the details description", rocketId: "rocketid1")
    static let starlink = Launch(id: "efgh", flightNumber: 2, name: "Starlink-18", date: Date(), links: links, success: false, details: "for starlink this is the details description", rocketId: "rocketid2")
  }
}
