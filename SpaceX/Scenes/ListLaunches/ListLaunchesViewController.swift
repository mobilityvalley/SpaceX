//
//  ListLaunchesViewController.swift
//  Space
//
//  Created by Eric Granger on 06/02/2021.
//

import UIKit
import Nuke

protocol ListLaunchesDisplayLogic: class
{
  func displaySomething(viewModel: ListLaunches.Something.ViewModel)
}

class ListLaunchesViewController: UIViewController, ListLaunchesDisplayLogic {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var interactor: ListLaunchesBusinessLogic?
    var router: (NSObjectProtocol & ListLaunchesRoutingLogic & ListLaunchesDataPassing)?

    
    var launches: [Launch]? {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
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
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "ShowLaunchDetail",
    //           let showLaunchViewController = segue.destination as? ShowLaunchViewController,
    //           let selectedCell = sender as? LaunchTableViewCell,
    //           let row = tableView.indexPath(for: selectedCell)?.row,
    //           let launches = launches {
    //            showLaunchViewController.launch = launches[row]
    //        }
    //    }

    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
      super.viewDidLoad()
        super.viewDidLoad()
        
        doSomething()
    }
    
    func doSomething() {
      let request = ListLaunches.Something.Request()
      interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: ListLaunches.Something.ViewModel) {
      //nameTextField.text = viewModel.name
    }
    
    // MARK: - Navigation
}

extension ListLaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchTableViewCell", for: indexPath) as! LaunchTableViewCell
        
        guard let launches = launches else { return cell }
        
        let launch = launches[indexPath.row]
        
        cell.containerView.layer.cornerRadius = Constants.corners
        cell.nameLabel.text = launch.name
        cell.dateLabel.text = Constants.dateFormatter.string(from: launch.date)
        
        if let success = launch.success {
            cell.successLabel.text = success ? "SUCCESS" : "FAILURE"
            cell.successLabel.textColor = success ? UIColor.systemGreen : UIColor.systemRed
        }

        cell.detailsLabel.text = launch.details
        
        if let flickr = launch.links.flickr.original.first, let url = URL(string: flickr) {
            Nuke.loadImage(with: url, into: cell.flickrImageView)
        }
        
        if let small = launch.links.patch.small, let url = URL(string: small) {
            Nuke.loadImage(with: url, into: cell.patchImageView)
        }
        
        return cell
    }
}
