//
//  NewsfeedPresenter.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright (c) 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
  
    switch response {
    
    case .some:
        print(".some Presenter" )
    case .presentNewsFeed:
        print(".presentNewsFeed Presenter" )
        viewController?.displayData(viewModel: .displayNewsFeed)
    @unknown default: break
    }
  }
  
}
