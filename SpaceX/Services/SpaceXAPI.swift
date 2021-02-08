//
//  SpaceXAPI.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import Foundation

class SpaceXAPI {
    
    // MARK: - Properties
    static let shared = SpaceXAPI()
    let baseUrl = "https://api.spacexdata.com/v4/"
    
    func launches(completion: @escaping (_ launches: [Launch]?, Bool?) -> Void) {
        let route = baseUrl + "launches/past"
        guard let url = URL(string: route) else {
            completion(nil, false)
            return
        }
        
        Network.request(url: url , type: [Launch].self) { (launches, error) in
            guard error == nil, let launches = launches else {
              completion(nil, false)
              return
            }
            let sortedLaunches = launches.sorted { $0.date > $1.date }
            completion(sortedLaunches, true)
        }
    }
    
    func rocket(_ id: String, completion: @escaping (_ rocket: Rocket?, Bool?) -> Void) {
        let route = baseUrl + "rockets/" + id
        guard let url = URL(string: route) else {
            completion(nil, false)
            return
        }
        
        Network.request(url: url , type: Rocket.self) { (rocket, error) in
            guard error == nil, let rocket = rocket else {
              completion(nil, false)
              return
            }
            completion(rocket, true)
        }
    }
}
