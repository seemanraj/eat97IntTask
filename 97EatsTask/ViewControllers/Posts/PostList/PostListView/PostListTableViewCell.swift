//
//  PostListTableViewCell.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit

class PostListTableViewCell: UITableViewCell {

    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var lblTags: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgUser.layer.cornerRadius  = self.imgUser.frame.size.width / 2

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
