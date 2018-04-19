//
//  DeficiencyTypeViewController.swift
//  InSpectionPro
//
//  Created by Mac OS on 01/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit

class DeficiencyTypeViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource {
    var delegate: CopyDataDelegate?

    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var cancelOutLet: UIButton!
    @IBOutlet weak var submitOutLet: UIButton!
    
    
    var copyArray : Array<String> = Array()
    var aliasDescription            : String = ""
    var itemList = ""
    var tag = 0
    var singleSelection: [Int] = []
    var selectSection = ""
    var clickedSection : Int?
    var itemsArray : Array<String> = Array()
    var selectedName : String = ""
    var deficiencyTypeArray : Array<String> = Array()
    var correctiveActtionArray : Array<String> = Array()
    var testArray : Array<String> = Array()
    var userInfo : Dictionary<String,Any> = Dictionary()
    

    @IBOutlet weak var deficencyTableView: UITableView!

    override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // Do any additional setup after loading the view.
        let nibName  = UINib(nibName: "CheekBoxDeficiencyTypeCell" , bundle: nil)
        deficencyTableView.register(nibName, forCellReuseIdentifier: "CheekBoxDeficiencyTypeCell")
        let nibName1  = UINib(nibName: "DeficiencyHeaderCell" , bundle: nil)
        deficencyTableView.register(nibName1, forCellReuseIdentifier: "DeficiencyHeaderCell")
        for i in 0 ..< deficiencyTypeArray.count + 1{
            userInfo.updateValue("0", forKey: "\(i)")
        }
    }
    
// MARK:- UITableViewDelegate AND UITableViewDataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return deficiencyTypeArray.count
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

    let cell = tableView.dequeueReusableCell(withIdentifier: "CheekBoxDeficiencyTypeCell", for: indexPath) as! CheekBoxDeficiencyTypeCell
        if(deficiencyTypeArray.count > 0) {
         cell.checkBoxTypeLabel.text = deficiencyTypeArray[indexPath.row]
        }
         cell.checkBoxButton.addTarget(self, action: #selector(DeficiencyTypeViewController.selectClicked), for: .touchUpInside)
    let image =  userInfo["\(indexPath.row)"] as? String == "1" ?  UIImage(named:"CheckBox_Selected") :  UIImage(named:"blue-checkbox-30.png")
         cell.checkBoxButton.setImage(image, for: UIControlState.normal)
         cell.checkBoxButton.tag = indexPath.row
         return cell
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "DeficiencyHeaderCell") as! DeficiencyHeaderCell
         return headerCell
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44.0
        
    }
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
// MARK:- Select Check Box Button For Multiple Selection on Check Box
    @objc func selectClicked(_ sender : UIButton){
        print("Check Box Clicked...")
        let currentValue = userInfo["\(sender.tag)"] as? String == "0" ? "1" : "0"
        userInfo["\(sender.tag)"] = currentValue
        if(currentValue == "0"){
        }else{
            var allCheck = false
            for i in 1 ..< userInfo.count{
                if(userInfo["\(i)"] as? String == "1"){
                    allCheck = true
                }else{
                    allCheck = false
                    break
                }
            }
        }
        deficencyTableView.reloadData()
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        print("Cancel Button Tapped...")
removeAnimate()
    }
    

    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if (tag == 1){
            print("Submit Button Tapped...")
            for i in 0 ..< userInfo.count{
                if (userInfo["\(i)"] as? String == "1"){
                    let selectedItemIndex = deficiencyTypeArray[i]
                    itemList = itemList + selectedItemIndex  + ","
                }
            }
            var listArray = itemList.components(separatedBy: ",")
            listArray.removeLast()
            itemList = ""
            for j in 0..<listArray.count{
                if(j == listArray.count - 1){
                    itemList = itemList + listArray[j]
                }else{
                    itemList = itemList + listArray[j] + ","
                }
            }
            if let delegate = self.delegate {
                delegate.dataToBeCopied(descriptionArray: itemList , tag)
                
            }
            removeAnimate()
        }else{
            print("Submit Button Tapped...")
            for i in 0 ..< userInfo.count{
                if (userInfo["\(i)"] as? String == "1"){
                    let selectedItemIndex = deficiencyTypeArray[i]
                        itemList = itemList + selectedItemIndex + ","
                }
            }
            var listArray = itemList.components(separatedBy: ",")
            listArray.removeLast()
            itemList = ""
            for j in 0..<listArray.count{
                if(j == listArray.count - 1){
                    itemList = itemList + listArray[j]
                }else{
                    itemList = itemList + listArray[j] + ","
                }
            }
              print(itemList)
            if let delegate = self.delegate {
                delegate.dataToBeCopied(descriptionArray: itemList, tag)
            }
            removeAnimate()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
