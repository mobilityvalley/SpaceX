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
            let launches: [Launch]
        }
        
        struct ViewModel {
            struct DisplayedLaunch {
                let name: String
                let date: String
                let successText: String?
                let successColor: UIColor?
                let details: String?
                let flickr: String?
                let patch: String?
                let youtubeId: String?
            }
            let displayedLaunches: [DisplayedLaunch]
        }
    }
}
