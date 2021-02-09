//
//  ShowLaunchModels.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

enum ShowLaunch
{
    // MARK: Use cases
    enum GetLaunch {
        struct Request {
        }
        
        struct Response {
            let launch: Launch
        }
        
        struct ViewModel {
            struct DisplayedLaunch {
                let name: String
                let patch: String?
                let flickr: String?
                let date: String
                let successText: String?
                let successColor: UIColor?
                let details: String?
                let rocketId: String?
                let youtubeId: String?
            }
            let displayedLaunch: DisplayedLaunch
        }
    }
    
    enum FetchRocket {
        struct Request {
            var rocketId: String
        }
        
        struct Response {
            var rocket: Rocket
        }
        
        struct ViewModel {
            struct DisplayedRocket {
                var name: String
                var height: String
                var mass: String
                var image: String?
            }
            var displayedRocket: DisplayedRocket
        }
    }
}


