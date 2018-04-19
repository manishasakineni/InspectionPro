//
//  LoginCell.swift
//  YISCustomerApp
//
//  Created by Calibrage Mac on 17/08/17.
//  Copyright © 2017 Calibrage Mac. All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {
    
    @IBOutlet weak var credentialTextField  : UITextField!
    @IBOutlet weak var verticalLine         : UILabel!
    //@IBOutlet weak var showPasswordButton   : UIButton!
    @IBOutlet weak var credentialTitle      : UILabel!
    
    
    @IBOutlet weak var verticalLineHeight   : NSLayoutConstraint!
    @IBOutlet var lineHorizontalPadding     : [NSLayoutConstraint]!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
  
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
