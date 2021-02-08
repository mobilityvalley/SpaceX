//
//  ShowLaunchViewController.swift
//  Space
//
//  Created by Eric Granger on 06/02/2021.
//

import UIKit
import Nuke
import XCDYouTubeKit
import AVKit

class ShowLaunchViewController: UIViewController {

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
    var launch: Launch!
    
    // MARK: - ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLaunch()
        getRocket()
    }
    
    func displayLaunch() {
        nameLabel.text = launch.name
        
        if let patch = launch.links.patch.small, let url = URL(string: patch) {
            Nuke.loadImage(with: url, into: patchImageView)
        }
        
        dateLabel.text = Constants.dateFormatter.string(from: launch.date)
        
        if let success = launch.success {
            successLabel.text = success ? "SUCCESS" : "FAILURE"
            successLabel.textColor = success ? UIColor.systemGreen : UIColor.systemRed
        }
        
        detailsLabel.text = launch.details
        
        if let flickr = launch.links.flickr.original.first, let url = URL(string: flickr) {
            Nuke.loadImage(with: url, into: flickrImageView)
        }
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
        let symbol = UIImage(systemName: "play.circle", withConfiguration: largeConfig)
        playButton.setImage(symbol, for: .normal)
    }
    
    func getRocket() {
        guard let rocketId = launch.rocketId else { return }
        
        SpaceXAPI.shared.rocket(rocketId) { rocket, success in
            if success == true, let rocket = rocket {
                self.displayRocket(rocket)
            }
        }
    }

    func displayRocket(_ rocket: Rocket) {
        rocketNameLabel.text = rocket.name
        rocketHeightLabel.text = rocket.height.meters.description + " m"
        rocketMassLabel.text = rocket.mass.kg.description + " kg"
        
        if let image = rocket.images.first, let url = URL(string: image) {
            Nuke.loadImage(with: url, into: rocketImageView)
        }
    }
    
    func playVideo() {
        guard let youtubeId = launch.links.youtubeId else { return }
        
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
