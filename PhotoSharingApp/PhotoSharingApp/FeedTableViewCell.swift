//
//  FeedTableViewCell.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 4.04.2022.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var commentText: UILabel!
    @IBOutlet var emailText: UILabel!
    @IBOutlet var feedImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
