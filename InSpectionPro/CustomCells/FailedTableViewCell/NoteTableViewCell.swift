//
//  NoteTableViewCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 30/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
      borderColor()
        
    }

// MARK:- Set Border Colors
    func borderColor(){
        
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
        noteTextView.layer.cornerRadius = 3.0
        noteTextView.layer.shadowColor = UIColor.lightGray.cgColor
        noteTextView.layer.shadowOffset = CGSize(width: 0, height: 3)
        noteTextView.layer.shadowOpacity = 0.6
        noteTextView.layer.shadowRadius = 2.0
        
        noteTextView.layer.borderWidth = 1
        noteTextView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
   
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
