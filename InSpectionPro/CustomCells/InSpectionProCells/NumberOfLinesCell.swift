//
//  NumberOfLinesCell.swift
//  InSpectionPro
//
//  Created by Mac OS on 29/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import CoreData

class NumberOfLinesCell: UITableViewCell {
    @IBOutlet weak var lineNameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lastExecutedDate: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var failedButton: UIButton!
    @IBOutlet weak var passedButton: UIButton!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
// Set Button And View Border Colors And CornerRadius
        backGroundView.layer.cornerRadius = 3.0
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.shadowOffset = CGSize(width: 0, height: 3)
        backGroundView.layer.shadowOpacity = 0.6
        backGroundView.layer.shadowRadius = 2.0
        
        failedButton.layer.borderWidth = 0.50
        failedButton.layer.cornerRadius = 3.0
        
        passedButton.layer.borderWidth = 0.50
        passedButton.layer.cornerRadius = 3.0
        
        borderColors()
    }
// MARK:- Set Status For All Lines Method (Passed Or Failed)
    func configureCellWith(_ model : AllModel){
      //  let person = Lines(context: PersistenceService.managedObjectContext)
        lineNameLabel.text = model.name
        if model.status == 0 {
            statusLabel.text = "Failed"
            statusLabel.textColor = UIColor.red

        }else{
            statusLabel.text = "Passed"
            statusLabel.textColor = UIColor.black
        }
        if(model.lastExecuted != ""){
           lastExecutedDate.text = returnEventDateWithoutTim1(selectedDateString: model.lastExecuted)
      }
    }
    
    // MARK:- Set DateFormat String
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            let dateString3 = invDtArray2[0]
            
            print(dateString1)
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString3)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "," + newDateStr1
    }
    
    func borderColors(){
        
        passedButton.layer.borderWidth = 1
        passedButton.layer.borderColor = UIColor(red: 108.0/255.0, green: 197.0/255.0, blue: 45.0/255.0, alpha: 1.0).cgColor
        
        failedButton.layer.borderWidth = 1
        failedButton.layer.borderColor = UIColor(red: 225.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

