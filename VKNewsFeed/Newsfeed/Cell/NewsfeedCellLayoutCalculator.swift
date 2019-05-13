//
//  NewsfeedCellLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 13/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit


struct Sizes: FeedCellsSizes {
    var postLabelFrame: CGRect
    var attachementFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellsSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
  
    func sizes(postText: String?, photoAttachement: FeedCellPhotoAttachementViewModel?) -> FeedCellsSizes {
        return Sizes(postLabelFrame: CGRect.zero, attachementFrame: CGRect.zero)
    }
    
    
}
