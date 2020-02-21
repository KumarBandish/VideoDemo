//
//  HomePageCollectionViewCell.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 19/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import AVKit

final class HomePageCollectionViewCell: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak private var videoThumbnailImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //MARK: view cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        videoThumbnailImageView.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoThumbnailImageView.image = nil
    }
    
    //MARK: Method
    func configureCollectionViewUI(urlString: String) {
        if let images = PersistentManager.shareInstance.fetchImage(url: urlString), !images.isEmpty, let imageData = images[0].img  {
            activityIndicatorView.isHidden = true
            activityIndicatorView.stopAnimating()
            videoThumbnailImageView.image = UIImage(data: imageData)
        } else {
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            AVAsset(url: URL(string: urlString) ?? URL(string: "")!).generateThumbnail { [weak self] (image) in
                DispatchQueue.main.async {
                    guard let image = image else { return }
                    PersistentManager.shareInstance.saveImage(data: image.jpegData(compressionQuality: 1.0), url: urlString)
                    self?.videoThumbnailImageView.image = image
                    self?.activityIndicatorView.isHidden = true
                    self?.activityIndicatorView.stopAnimating()
                }
            }
        }
    }
}
