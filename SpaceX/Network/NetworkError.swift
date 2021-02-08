//
//  SpaceXAPI.swift
//  Space
//
//  Created by Eric Granger on 06/02/2021.
//

import Foundation

enum NetworkError: Error {
    case invalidJSON
    case invalidPath
    case parseError
    case requestError
    case dateParseError
}
