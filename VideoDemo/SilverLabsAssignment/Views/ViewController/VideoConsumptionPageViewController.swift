//
//  VideoConsumptionPageViewController.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 21/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit

typealias VideoIndex = (feed: String, index: Int)

final class VideoConsumptionPageViewController: UIPageViewController {
    
    //MARK: Properties
    var currentVideoIndex = 0
    var nodeList = [Node]()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presentInitialFeed()
    }
    
    //MARK: Methods
    private func setupUI() {
        self.dataSource = self
        self.delegate = self
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(closeView))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func presentInitialFeed() {
        let viewController = VideoViewController.initialize(urlString: nodeList[currentVideoIndex].video?.encodeURL ?? "", andIndex: currentVideoIndex, isPlaying: false)
        setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
    }
    
    private func fetchPreviousVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: currentVideoIndex - 1)
    }
    
    private func fetchNextVideoIndex() -> VideoIndex? {
        return getVideoIndex(atIndex: currentVideoIndex + 1)
    }
    
    private func getVideoIndex(atIndex index: Int) -> VideoIndex? {
        guard index >= 0 && index < nodeList.count else {
            return nil
        }
        return (feed: nodeList[index].video?.encodeURL ?? "", index: index)
    }
    
    private func updateVideoIndex(fromIndex index: Int) {
        currentVideoIndex = index
    }
}

//MARK: UIPageViewControllerDataSource
extension VideoConsumptionPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let previousVideoIndex = fetchPreviousVideoIndex()?.index else {
            return nil
        }
        return VideoViewController.initialize(urlString: nodeList[previousVideoIndex].video?.encodeURL ?? "", andIndex: previousVideoIndex, isPlaying: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let nextVideoIndex = fetchNextVideoIndex()?.index else {
            return nil
        }
        return VideoViewController.initialize(urlString: nodeList[nextVideoIndex].video?.encodeURL ?? "", andIndex: nextVideoIndex, isPlaying: false)
    }
}

//MARK: UIPageViewControllerDelegate
extension VideoConsumptionPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        if
            let viewController = pageViewController.viewControllers?.first as? VideoViewController,
            let previousViewController = previousViewControllers.first as? VideoViewController
        {
            previousViewController.pausePlayingVideo()
            viewController.startPlayingVideo()
            self.updateVideoIndex(fromIndex: viewController.index)
        }
    }
}
