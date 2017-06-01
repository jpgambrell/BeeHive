//
//  AddUserTableViewCell.swift
//  BeeHive
//
//  Created by John Gambrell on 6/1/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit

class AddUserTableViewCell: UITableViewCell {

    @IBOutlet weak var inputUserView: UIView! {
    didSet {
        inputUserView.isHidden = true
    }
}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
