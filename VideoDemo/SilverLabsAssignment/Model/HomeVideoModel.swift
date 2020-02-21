//
//  HomeVideoModel.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 20/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import UIKit
import AVKit

//MARK: VideoList
struct VideoList: Codable {
    var title: String?
    var nodes: [Node]?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case nodes = "nodes"
    }
}

// MARK: - Node
struct Node: Codable {
    var video: Video?

    enum CodingKeys: String, CodingKey {
        case video = "video"
    }
}


// MARK: - Video
struct Video: Codable {
    var encodeURL: String?
    
//    mutating func getVideoThumbnail(urlString: String) {
//        
//        AVAsset(url: URL(string: encodeURL ?? "") ?? URL(string: "")!).generateThumbnail { (image) in
//
//            PersistentManager.shareInstance.saveImage(data: image?.jpegData(compressionQuality: 1.0), url: urlString)
//        }
//    }
    
    enum CodingKeys: String, CodingKey {
        case encodeURL = "encodeUrl"
    }
}


