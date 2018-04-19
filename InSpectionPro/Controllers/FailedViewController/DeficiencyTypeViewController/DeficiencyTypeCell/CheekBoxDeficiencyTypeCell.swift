//
//  CheekBoxDeficiencyTypeCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 01/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class CheekBoxDeficiencyTypeCell: UITableViewCell {
    @IBOutlet weak var checkBoxTypeLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        borderColor()
    }

// MARk:- Check Box BorderColor
    func borderColor(){
        checkBoxButton.layer.borderWidth = 2
        checkBoxButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
