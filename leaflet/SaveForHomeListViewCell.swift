//
//  SaveForHomeListViewCell.swift
//  leaflet
//
//  Created by Cindy Zeng on 5/4/15.
//  Copyright (c) 2015 parks-and-rec. All rights reserved.
//

import Foundation
import UIKit

class SaveForHomeListViewCell: UITableViewCell {
    
    @IBOutlet weak var poiName: UILabel!
    @IBOutlet weak var poiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poiName.textColor = UIColor(hex: GlobalConstants.bodyTextColor)
        poiName.font = GlobalConstants.defaultFont
        poiImage.layer.cornerRadius = poiImage.frame.size.width / 2;
        poiImage.clipsToBounds = true
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
