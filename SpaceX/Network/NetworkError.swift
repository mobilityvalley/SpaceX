//
//  SpaceXAPI.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidJSON
    case invalidPath
    case parseError
    case requestError
    case dateParseError
}
