//
//  ListLaunchesWorker.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

class ListLaunchesWorker {
    func fetchLaunches(completionHandler: @escaping ([Launch]) -> Void) {
        SpaceXAPI.shared.launches() { launches, success in
            if success == true, let launches = launches {
                completionHandler(launches)
            }
        }
    }
}
