//
//  DeficiencySectionCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 01/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class DeficiencySectionCell: UITableViewCell {

    @IBOutlet weak var numberOfDeficiencyCount: UILabel!
    
    @IBOutlet weak var lineNumberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
