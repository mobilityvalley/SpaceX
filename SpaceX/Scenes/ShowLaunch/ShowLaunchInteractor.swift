//
//  ShowLaunchInteractor.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

protocol ShowLaunchBusinessLogic {
    func getLaunch(request: ShowLaunch.GetLaunch.Request)
    func fetchRocket(request: ShowLaunch.FetchRocket.Request)
}

protocol ShowLaunchDataStore {
    var launch: Launch! { get set }
    var rocket: Rocket? { get }
}

class ShowLaunchInteractor: ShowLaunchBusinessLogic, ShowLaunchDataStore
{
    var presenter: ShowLaunchPresentationLogic?
    var worker: ShowLaunchWorker?
    
    var launch: Launch!
    var rocket: Rocket?
    
    // MARK: Do something
    
    func getLaunch(request: ShowLaunch.GetLaunch.Request) {        
        let response = ShowLaunch.GetLaunch.Response(launch: launch)
        presenter?.presentLaunch(response: response)
        
        if let rocketId = response.launch.rocketId {
            let request = ShowLaunch.FetchRocket.Request(rocketId: rocketId)
            fetchRocket(request: request)
        }
    }
    
    func fetchRocket(request: ShowLaunch.FetchRocket.Request) {
        worker = ShowLaunchWorker()
        worker?.fetchRocket(request.rocketId) { rocket in
            self.rocket = rocket
            let response = ShowLaunch.FetchRocket.Response(rocket: rocket)
            self.presenter?.presentFetchedRocket(response: response)
        }
    }
}
