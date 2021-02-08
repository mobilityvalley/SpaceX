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
            var launch: Launch
        }
        
        struct ViewModel {
            struct DisplayedLaunch {
                var name: String
                var patch: String?
                var flickr: String?
                var date: String
                var successText: String?
                var successColor: UIColor?
                var details: String?
                var rocketId: String?
                var youtubeId: String?
            }
            var displayedLaunch: DisplayedLaunch
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


