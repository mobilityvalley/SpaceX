//
//  ShowLaunchPresenter.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

protocol ShowLaunchPresentationLogic {
    func presentLaunch(response: ShowLaunch.GetLaunch.Response)
    func presentFetchedRocket(response: ShowLaunch.FetchRocket.Response)
}

class ShowLaunchPresenter: ShowLaunchPresentationLogic {
    weak var viewController: ShowLaunchDisplayLogic?
    
    func presentLaunch(response: ShowLaunch.GetLaunch.Response) {
        let launch = response.launch
        
        let patch = launch.links.patch.small
        let flickr = launch.links.flickr.original.first
        
        let date = Constants.dateFormatter.string(from: launch.date)
        
        var successText = ""
        var successColor: UIColor = .white
        
        if let success = launch.success {
            successText = success ? "SUCCESS" : "FAILURE"
            successColor = success ? UIColor.systemGreen : UIColor.systemRed
        }
        
        let youtubeId = launch.links.youtubeId
        
        let displayedLaunch = ShowLaunch.GetLaunch.ViewModel.DisplayedLaunch(name: launch.name, patch: patch, flickr: flickr, date: date, successText: successText, successColor: successColor, details: launch.details, rocketId: launch.rocketId, youtubeId: youtubeId)
        
        let viewModel = ShowLaunch.GetLaunch.ViewModel(displayedLaunch: displayedLaunch)
        viewController?.displayLaunch(viewModel: viewModel)
    }
    
    func presentFetchedRocket(response: ShowLaunch.FetchRocket.Response) {
        let rocket = response.rocket
        
        let height = rocket.height.meters.description + " m"
        let mass = rocket.mass.kg.description + " kg"
        let image = rocket.images.first
        
        let displayedRocket = ShowLaunch.FetchRocket.ViewModel.DisplayedRocket(name: rocket.name, height: height, mass: mass, image: image)
        
        
        let viewModel = ShowLaunch.FetchRocket.ViewModel(displayedRocket: displayedRocket)
        viewController?.displayRocket(viewModel: viewModel)
    }
}
