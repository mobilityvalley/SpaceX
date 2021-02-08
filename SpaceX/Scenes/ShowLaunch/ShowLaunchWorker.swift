//
//  ShowLaunchWorker.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

class ShowLaunchWorker {
    func fetchRocket(_ rocketId: String, completionHandler: @escaping (Rocket) -> Void) {
        SpaceXAPI.shared.rocket(rocketId) { rocket, success in
            if success == true, let rocket = rocket {
                completionHandler(rocket)
            }
        }
    }
}
