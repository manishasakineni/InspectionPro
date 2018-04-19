//
//  HeaderSectionCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 29/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class HeaderSectionCell: UITableViewCell {

    @IBOutlet weak var failedThumbButton: UIButton!
    @IBOutlet weak var unsavedButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var allCountLabel: UILabel!
    @IBOutlet weak var unSavedCountLabel: UILabel!
    
    @IBOutlet weak var failedCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        borderColor()
    }

// MARK:- Set Button Corner Radius
    func borderColor(){
        
        //allButton.layer.borderWidth = 1
        allButton.layer.cornerRadius = 8
        unsavedButton.layer.cornerRadius = 8
        failedThumbButton.layer.cornerRadius = 8

    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
}
