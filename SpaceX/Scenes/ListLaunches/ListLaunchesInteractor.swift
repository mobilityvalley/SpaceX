//
//  ListLaunchesInteractor.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

protocol ListLaunchesBusinessLogic {
    func fetchLaunches(request: ListLaunches.FetchLaunches.Request)
}

protocol ListLaunchesDataStore {
    var launches: [Launch]? { get }
}

class ListLaunchesInteractor: ListLaunchesBusinessLogic, ListLaunchesDataStore {
    var presenter: ListLaunchesPresentationLogic?
    var worker: ListLaunchesWorker?
    
    var launches: [Launch]?
    
    // MARK: Fetch Launches
    func fetchLaunches(request: ListLaunches.FetchLaunches.Request) {
        worker = ListLaunchesWorker()
        worker?.fetchLaunches() { launches in
            self.launches = launches
            let response = ListLaunches.FetchLaunches.Response(launches: launches)
            self.presenter?.presentFetchedLaunches(response: response)
        }
    }
}
