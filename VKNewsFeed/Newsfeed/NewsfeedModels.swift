//
//  NewsfeedModels.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright (c) 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsfeed
        case getUser
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealdedPostIds: [Int])
        case presentUserInfo(user: UserResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
        case displayUser(userViewModel: UserViewModel)
      }
    }
  }
  
}
struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}
 
struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachements: [FeedCellPhotoAttachementViewModel]
        var sizes: FeedCellsSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachementViewModel {
        var photoUrlString: String? 
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
