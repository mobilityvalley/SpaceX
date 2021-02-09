//
//  ShowLaunchRouter.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//  

import UIKit

@objc protocol ShowLaunchRoutingLogic {
}

protocol ShowLaunchDataPassing {
    var dataStore: ShowLaunchDataStore? { get }
}

class ShowLaunchRouter: NSObject, ShowLaunchRoutingLogic, ShowLaunchDataPassing {
    weak var viewController: ShowLaunchViewController?
    var dataStore: ShowLaunchDataStore?
}
