//
//  NewsfeedInteractor.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright (c) 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    private var revealdedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        
        switch request {
            
        case .getNewsfeed:
            fetcher.getFeed { [weak self] (feedResponse) in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
            
        case .revealPostIds(let postId):
            revealdedPostIds.append(postId)
            presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        self.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse,
                                                                                                   revealdedPostIds: revealdedPostIds))
    }
    
}
