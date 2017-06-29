//
//  TasksTableViewCell.swift
//  BeeHive
//
//  Created by John Gambrell on 6/27/17.
//  Copyright © 2017 JPG. All rights reserved.
//

import UIKit
import MapKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var progressHeaderView: ProgressLineView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var locationMapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
