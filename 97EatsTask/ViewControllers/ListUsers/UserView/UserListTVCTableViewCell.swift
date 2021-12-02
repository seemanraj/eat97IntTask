//
//  UserListTVCTableViewCell.swift
//  97EatsTask
//
//  Created by System Admin on 01/12/21.
//

import UIKit

class UserListTVCTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lbluserName: UILabel!
    @IBOutlet weak var btnPre   : UIButton!
    @IBOutlet weak var btnEdit   : UIButton!
    @IBOutlet weak var btnDel   : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
