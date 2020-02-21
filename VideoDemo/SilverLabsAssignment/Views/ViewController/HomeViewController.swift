//
//  ViewController.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 19/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import AVKit

final class HomeViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var homePageTableViewController: UITableView!
    
    //MARK: Properties
    private var homeScreenViewModel = HomeScreenViewModel()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        homeScreenViewModel.delegate = self
        homeScreenViewModel.getVideoListFromFile()
    }
}

//MARK: TableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeScreenViewModel.videoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTableViewCell", for: indexPath) as! HomePageTableViewCell
        let video = homeScreenViewModel.videoList[indexPath.section]
        cell.initializeData(video: video, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return customHeaderView(tableView: tableView,section: section)
    }
    
    private func customHeaderView(tableView: UITableView,section: Int) -> UIView? {
        let video = homeScreenViewModel.videoList[section]
        let headerView = UIView(frame: CGRect(x: 20, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let titleLabel = UILabel(frame: headerView.frame)
        titleLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        titleLabel.text = video.title
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
//MARK: TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

//MARK: ViewModelDelegate
extension HomeViewController: HomeScreenViewModelDelegate {
    func dataRetrievingSuccessfull() {
        homePageTableViewController.reloadData()
    }
    
    func dataRetrievalFailure(error: Error) {
        self.showToast(message: error.localizedDescription, font: UIFont(name: Strings.helvetica, size: 15) ?? UIFont())
    }
}

//MARK: HomePageTableViewCellDelegate
extension HomeViewController: HomePageTableViewCellDelegate {
    
    func playVideo(nodes: [Node], index: Int) {
        let consumptionVC = storyboard?.instantiateViewController(withIdentifier: "VideoConsumptionPageViewController") as! VideoConsumptionPageViewController
        consumptionVC.currentVideoIndex = index
        consumptionVC.nodeList = nodes
        consumptionVC.modalPresentationStyle = .fullScreen
        self.present(consumptionVC, animated: false, completion: nil)
    }
}
