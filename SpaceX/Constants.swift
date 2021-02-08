//
//  Constants.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import Foundation
import UIKit

struct Constants {
    // MARK: - Corners
    static let corners: CGFloat = 16.0
    
    // MARK: - Date Formatter
    static let dateFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
      return dateFormatter
    }()
}
