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
            let date = Constants.dateFormatter.string(from: launch.date)
            let flickr = launch.links.flickr.original.first
            let patch = launch.links.patch.small
            let youtubeId = launch.links.youtubeId
            
            var successText = ""
            var successColor: UIColor = .white
            
            if let success = launch.success {
                successText = success ? "SUCCESS" : "FAILURE"
                successColor = success ? UIColor.systemGreen : UIColor.systemRed
            }
            
            let displayedLaunch = ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch(name: launch.name, date: date, successText: successText, successColor: successColor, details: launch.details, flickr: flickr, patch: patch, youtubeId: youtubeId)
            
            displayedLaunches.append(displayedLaunch)
        }
        
        let viewModel = ListLaunches.FetchLaunches.ViewModel(displayedLaunches: displayedLaunches)
        viewController?.displayFetchedLaunches(viewModel: viewModel)
    }
}
