//
//  PointsOfInterestListViewCell.swift
//  leaflet
//
//  Created by Cindy Zeng on 4/19/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import Foundation
import UIKit

class PointsOfInterestListViewCell: UITableViewCell {
    
    @IBOutlet weak var poiName: UILabel!
    @IBOutlet weak var locationAway: UILabel!
    @IBOutlet weak var poiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poiName.textColor = UIColor(hex: GlobalConstants.bodyTextColor)
        locationAway.font = GlobalConstants.subHeadingFont
        poiImage.layer.cornerRadius = poiImage.frame.size.width / 2;

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

