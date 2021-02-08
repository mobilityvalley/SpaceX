//
//  ListLaunchesViewController.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import UIKit
import Nuke

protocol ListLaunchesDisplayLogic: class {
    func displayFetchedLaunches(viewModel: ListLaunches.FetchLaunches.ViewModel)
}

class ListLaunchesViewController: UIViewController, ListLaunchesDisplayLogic {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var interactor: ListLaunchesBusinessLogic?
    var router: (NSObjectProtocol & ListLaunchesRoutingLogic & ListLaunchesDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ListLaunchesInteractor()
        let presenter = ListLaunchesPresenter()
        let router = ListLaunchesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Fetch Launches
    var displayedLaunches: [ListLaunches.FetchLaunches.ViewModel.DisplayedLaunch] = []
    
    func fetchLaunches() {
        let request = ListLaunches.FetchLaunches.Request()
        interactor?.fetchLaunches(request: request)
    }
    
    func displayFetchedLaunches(viewModel: ListLaunches.FetchLaunches.ViewModel) {
        displayedLaunches = viewModel.displayedLaunches
        tableView.reloadData()
    }
}

extension ListLaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedLaunches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedLaunch = displayedLaunches[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as! LaunchTableViewCell
        
        cell.containerView.layer.cornerRadius = Constants.corners
        cell.nameLabel.text = displayedLaunch.name
        cell.dateLabel.text = displayedLaunch.date
        
        cell.successLabel.text = displayedLaunch.successText
        cell.successLabel.textColor = displayedLaunch.successColor
        
        cell.detailsLabel.text = displayedLaunch.details
        
        if let flickr = displayedLaunch.flickr, let url = URL(string: flickr) {
            Nuke.loadImage(with: url, into: cell.flickrImageView)
        }
        
        if let patch = displayedLaunch.patch, let url = URL(string: patch) {
            Nuke.loadImage(with: url, into: cell.patchImageView)
        }
        
        return cell
    }
}
