//
//  HomeScreenViewModel.swift
//  SilverLabsAssignment
//
//  Created by Bandish Kumar on 20/02/20.
//  Copyright © 2020 Bandish Kumar. All rights reserved.
//

import Foundation
import AVKit

protocol HomeScreenViewModelDelegate: class {
    func dataRetrievingSuccessfull()
    func dataRetrievalFailure(error: Error)
}

final class HomeScreenViewModel {
    
    //MARK: Outlets
    var videoList = [VideoList]()
    weak var delegate: HomeScreenViewModelDelegate?
    
    //MARK: Methods
    func getVideoListFromFile() {
        if let url = Bundle.main.url(forResource: Strings.assignment, withExtension: Strings.json) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.videoList = try decoder.decode([VideoList].self, from: data)
                self.delegate?.dataRetrievingSuccessfull()
            } catch {
                self.delegate?.dataRetrievalFailure(error: error)
            }
        }
    }
    
    
}
