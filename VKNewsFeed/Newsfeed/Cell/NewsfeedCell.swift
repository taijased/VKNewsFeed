//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Maxim Spiridonov on 12/05/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlStrng: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments : String? { get }
    var shares: String? { get }
    var views: String? { get }
}

class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var iconImageView: WebImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var eyeLabel: UILabel!
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageURL: viewModel.iconUrlStrng)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        eyeLabel.text = viewModel.views
    }
}
