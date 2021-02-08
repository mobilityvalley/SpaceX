//
//  ShowLaunchRouter.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

@objc protocol ShowLaunchRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ShowLaunchDataPassing {
    var dataStore: ShowLaunchDataStore? { get }
}

class ShowLaunchRouter: NSObject, ShowLaunchRoutingLogic, ShowLaunchDataPassing {
    weak var viewController: ShowLaunchViewController?
    var dataStore: ShowLaunchDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ShowLaunchViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ShowLaunchDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
