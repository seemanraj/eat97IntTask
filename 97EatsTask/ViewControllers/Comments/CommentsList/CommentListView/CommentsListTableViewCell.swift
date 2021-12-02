//
//  CommentsListTableViewCell.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit

class CommentsListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var btnDel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.userImage.layer.cornerRadius  = self.userImage.frame.size.width / 2

        // Configure the view for the selected state
    }
    
}
