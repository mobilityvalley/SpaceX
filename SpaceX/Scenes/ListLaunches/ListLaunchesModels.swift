//
//  ListLaunchesModels.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

enum ListLaunches {
    // MARK: Use cases
    enum FetchLaunches {
        struct Request {
        }
        
        struct Response {
            var launches: [Launch]
        }
        
        struct ViewModel {
            struct DisplayedLaunch {
                var name: String
                var date: String
                var successText: String?
                var successColor: UIColor?
                var details: String?
                var flickr: String?
                var patch: String?
                var youtubeId: String?
            }
            var displayedLaunches: [DisplayedLaunch]
        }
    }
}
