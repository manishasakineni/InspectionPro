//
//  FailedTableViewCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 30/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class FailedTableViewCell: UITableViewCell {

    @IBOutlet weak var pickerTitleLabel: UILabel!
    
    @IBOutlet weak var differentTypesPickerTF: UITextField!
    
    @IBOutlet weak var pickerArrowImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        differentTypesPickerTF.tintColor = UIColor.clear

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
