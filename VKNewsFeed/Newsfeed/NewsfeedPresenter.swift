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
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        
        switch response {
            
        case .presentNewsFeed(let feed, let revealdedPostIds):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds )
            }
            let feedViewModel = FeedViewModel.init(cells: cells )
            viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
            
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachements = self.photoAttachements(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealdedPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachements: photoAttachements, isFullSizedPost: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formmattedCouner(feedItem.likes?.count),
                                       comments: formmattedCouner(feedItem.comments?.count),
                                       shares: formmattedCouner(feedItem.reposts?.count),
                                       views: formmattedCouner(feedItem.views?.count),
                                       photoAttachements: photoAttachements,
                                       sizes: sizes)
    }
    
    private func formmattedCouner(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if 4...5 ~= counterString.count {
            counterString = String(counterString.dropLast(3) + "K")
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6) + "M")
        }
        
        return counterString
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        
        return profileRepresentable!
    }
    
    private func photoAttachement(feedItem: FeedItem) ->  FeedViewModel.FeedCellPhotoAttachment?  {
        guard
            let photo = feedItem.attachments?.compactMap({ (attachement) in
                attachement.photo
            }),
            let firstPhoto = photo.first
        else {
            return nil
        }
        
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          width: firstPhoto.width,
                                                          height: firstPhoto.height
        )
    }
    
    private func photoAttachements(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap({ (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG, width: photo.width, height: photo.height)
        })
    }

}
