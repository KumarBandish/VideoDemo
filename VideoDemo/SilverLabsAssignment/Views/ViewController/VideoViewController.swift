//
//  VideoViewController.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 21/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import AVKit

final class VideoViewController: AVPlayerViewController {
    
    //MARK: Properties
    var index: Int!
    private var urlString: String!
    private var isPlaying: Bool!
    static var sceneIdentifier: String {
        return String(describing: self)
    }
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseVideoURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        player?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        player?.pause()
    }
    
    //MARK: Initializer
    static func initialize(urlString: String, andIndex index: Int, isPlaying: Bool = false) -> UIViewController {
        let viewController = VideoViewController.getInstanceOfVideoVC()
        viewController.urlString = urlString
        viewController.index = index
        viewController.isPlaying = isPlaying
        return viewController
    }
    
    static func getInstanceOfVideoVC() -> Self {
        let storyboard = UIStoryboard(name: Strings.main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: self.sceneIdentifier)
        guard let conformingViewController = viewController as? Self else {
            fatalError(Strings.view_controller_error_text + "\(self)")
        }
        return conformingViewController
    }
    
    //MARK: Methods
    func initialiseVideoURL() {
        guard let url = URL(string: urlString) else { return }
        player = AVPlayer(url: url)
        isPlaying ? startPlayingVideo() : nil
    }
    
    func startPlayingVideo() {
        player?.play()
    }
    
    func pausePlayingVideo() {
        player?.pause()
    }
}
