//
//  ListLaunchesRouter.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

@objc protocol ListLaunchesRoutingLogic {
    func routeToShowLaunch(segue: UIStoryboardSegue?)
}

protocol ListLaunchesDataPassing {
    var dataStore: ListLaunchesDataStore? { get }
}

class ListLaunchesRouter: NSObject, ListLaunchesRoutingLogic, ListLaunchesDataPassing {
    weak var viewController: ListLaunchesViewController?
    var dataStore: ListLaunchesDataStore?
    
    // MARK: Routing
    func routeToShowLaunch(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowLaunchViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowLaunch(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ShowLaunchViewController") as! ShowLaunchViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowLaunch(source: dataStore!, destination: &destinationDS)
            navigateToShowLaunch(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    func navigateToShowLaunch(source: ListLaunchesViewController, destination: ShowLaunchViewController) {
      source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToShowLaunch(source: ListLaunchesDataStore, destination: inout ShowLaunchDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.launch = source.launches?[selectedRow!]
    }
}
