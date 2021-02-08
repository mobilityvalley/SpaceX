//
//  ShowLaunchViewController.swift
//  SpaceX
//
//  Created by Eric Granger on 08/02/2021.
//

import UIKit
import Nuke
import XCDYouTubeKit
import AVKit

protocol ShowLaunchDisplayLogic: class {
    func displayLaunch(viewModel: ShowLaunch.GetLaunch.ViewModel)
    func displayRocket(viewModel: ShowLaunch.FetchRocket.ViewModel)
}

class ShowLaunchViewController: UIViewController, ShowLaunchDisplayLogic {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var flickrImageView: UIImageView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var patchImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketHeightLabel: UILabel!
    @IBOutlet weak var rocketMassLabel: UILabel!
    @IBOutlet weak var rocketImageView: UIImageView!
    
    // MARK: - IBAction
    @IBAction func playTouched(_ sender: Any) {
        playVideo()
    }
    
    // MARK: - Properties
    
    var interactor: ShowLaunchBusinessLogic?
    var router: (NSObjectProtocol & ShowLaunchRoutingLogic & ShowLaunchDataPassing)?
    var youtubeId: String?
    
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
        let interactor = ShowLaunchInteractor()
        let presenter = ShowLaunchPresenter()
        let router = ShowLaunchRouter()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getLaunch()
    }
    
    // MARK: Launch
    func getLaunch() {
        let request = ShowLaunch.GetLaunch.Request()
        interactor?.getLaunch(request: request)
    }
    
    func displayLaunch(viewModel: ShowLaunch.GetLaunch.ViewModel) {
        let displayedLaunch = viewModel.displayedLaunch
        youtubeId = viewModel.displayedLaunch.youtubeId
        
        nameLabel.text = displayedLaunch.name
        
        if let patch = displayedLaunch.patch, let url = URL(string: patch) {
            Nuke.loadImage(with: url, into: patchImageView)
        }
        
        dateLabel.text = displayedLaunch.date
        
        successLabel.text = displayedLaunch.successText
        successLabel.textColor = displayedLaunch.successColor
        
        detailsLabel.text = displayedLaunch.details
        
        if let flickr = displayedLaunch.flickr, let url = URL(string: flickr) {
            Nuke.loadImage(with: url, into: flickrImageView)
        }
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let symbol = UIImage(systemName: "play.circle", withConfiguration: largeConfig)
        playButton.setImage(symbol, for: .normal)
    }
    
    // MARK: Rocket
    func displayRocket(viewModel: ShowLaunch.FetchRocket.ViewModel) {
        let displayedRocket = viewModel.displayedRocket
        
        rocketNameLabel.text = displayedRocket.name
        rocketHeightLabel.text = displayedRocket.height
        rocketMassLabel.text = displayedRocket.mass
        
        if let image = displayedRocket.image, let url = URL(string: image) {
            Nuke.loadImage(with: url, into: rocketImageView)
        }
    }
    
    // MARK: Play Video
    func playVideo() {
        guard let youtubeId = youtubeId else { return }
        
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        weak var weakPlayerViewController = playerViewController
        
        XCDYouTubeClient.default().getVideoWithIdentifier(youtubeId) { video, error in
            if let streamURL = (video?.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ??
                                    video?.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue] ??
                                    video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] ??
                                    video?.streamURLs[XCDYouTubeVideoQuality.small240.rawValue]) {
                weakPlayerViewController?.player = AVPlayer(url: streamURL)
                weakPlayerViewController?.player?.play()
            }
        }
    }
}
