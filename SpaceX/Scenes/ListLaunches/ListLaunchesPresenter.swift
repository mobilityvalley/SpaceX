//
//  ListLaunchesPresenter.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

protocol ListLaunchesPresentationLogic {
    func presentFetchedLaunches(response: ListLaunches.FetchLaunches.Response)
}

class ListLaunchesPresenter: ListLaunchesPresentationLogic {
    weak var viewController: ListLaunchesDisplayLogic?
    
    func presentFetchedLaunches(response: ListLaunches.FetchLaunches.Response) {
        var displayedLaunches: [ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch] = []
        for launch in response.launches {
            let flickr = launch.links.flickr.original.first
            let patch = launch.links.patch.small
            let youtubeId = launch.links.youtubeId
            let displayedLaunch = ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch(name: launch.name, date: launch.date, success: launch.success, details: launch.details, flickr: flickr, patch: patch, youtubeId: youtubeId)
            displayedLaunches.append(displayedLaunch)
        }
        
        let viewModel = ListLaunches.FetchLaunches.ViewModel(displayedLaunches: displayedLaunches)
        viewController?.displayFetchedLaunches(viewModel: viewModel)
    }
}
