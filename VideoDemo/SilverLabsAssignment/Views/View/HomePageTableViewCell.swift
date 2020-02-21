//
//  HomePageTableViewCell.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 19/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import AVKit

protocol HomePageTableViewCellDelegate: class {
    func playVideo(nodes: [Node], index: Int)
}

final class HomePageTableViewCell: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak private var homePageCollectionView: UICollectionView!
    
    //MARK: Properties
    var video : VideoList?
    weak var delegate: HomePageTableViewCellDelegate?
    
    //MARK: ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Initializer
    func initializeData(video: VideoList?,delegate: HomePageTableViewCellDelegate?) {
        self.video = video
        self.delegate = delegate
    }
}

//MARK: UICollectionViewDataSource
extension HomePageTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.video?.nodes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let urlString = self.video?.nodes?[indexPath.row].video?.encodeURL else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollectionViewCell", for: indexPath) as! HomePageCollectionViewCell
        cell.configureCollectionViewUI(urlString: urlString)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension HomePageTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nodes = self.video?.nodes else { return }
        delegate?.playVideo(nodes: nodes, index: indexPath.row)
    }
}

//MARK:UICollectionViewDelegateFlowLayout
extension HomePageTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 170)
    }
}
