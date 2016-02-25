//
//  ReposViewCell.swift
//  GithubDemo
//
//  Created by Jay Liew on 2/24/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ReposViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var forksImageView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
