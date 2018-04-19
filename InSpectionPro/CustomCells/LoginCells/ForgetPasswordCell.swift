//
//  ForgetPasswordCell.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 17/08/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import UIKit

class ForgetPasswordCell: UITableViewCell {
    
    @IBOutlet weak var rememberMeButton     : UIButton!
    @IBOutlet weak var forgotPasswordButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
// MARK:- Remember Button Method
    func configureCellWith(_ areCredentialsSaved : Bool) {
        
        areCredentialsSaved == true ?
            rememberMeButton.setImage(#imageLiteral(resourceName: "CheckBox_Selected"), for: UIControlState.normal) :
            rememberMeButton.setImage(#imageLiteral(resourceName: "CheckBox_Unselected"), for: UIControlState.normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
