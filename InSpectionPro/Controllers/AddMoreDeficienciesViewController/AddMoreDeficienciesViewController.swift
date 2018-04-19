//
//  AddMoreDeficienciesViewController.swift
//  InSpectionPro
//
//  Created by praveen dole on 3/21/18.
//  Copyright © 2018 Mac OS. All rights reserved.
//

import UIKit

class AddMoreDeficienciesViewController: UIViewController {

    
    @IBOutlet weak var inspectionTitle: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    
    
    var delegate: AddDeficienciDelegate?
    var deficencyCount  = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var allModelArray : Array<AllModel> = Array()
    var failedTableViewDataArray : Array<AllModel> = Array()
    var failed = "0"
    var noFailed = "0"
    var isDataChanged = false
    var appVersion          : String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
// UIButtos Shadow Animations
        yesButton.layer.cornerRadius = 3.0
        yesButton.layer.shadowColor = UIColor.lightGray.cgColor
        yesButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        yesButton.layer.shadowOpacity = 0.6
        yesButton.layer.shadowRadius = 2.0
        
        noButton.layer.cornerRadius = 3.0
        noButton.layer.shadowColor = UIColor.lightGray.cgColor
        noButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        noButton.layer.shadowOpacity = 0.6
        noButton.layer.shadowRadius = 2.0
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
      

    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        Utilities.setupAddMoreDeficienciesViewControllerNavBarColorInCntrWithColor(backImage: "backrsz_v_logo", cntr:self, titleView: nil, withText: "", backTitle: " InspectionPro", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")
        
        //navigationItem.leftBarButtonItems = []
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)


    }
    @IBAction func noButtonTapped(_ sender: Any) {
        
        
     //   if isDataChanged == true {
            delegate?.noButtonCount(Int(noFailed)!)

     //   }
        self.appDelegate.window?.makeToast("Please wait...", duration:kToastDuration, position:CSToastPositionCenter)

        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "rootVC") as! ViewController
      
        self.navigationController?.popViewController(animated: true)
          removeAnimate()
   
    }
   
    @IBAction func yesButtonTapped(_ sender: UIButton) {
  

        delegate?.failedCount(Int(failed)!)

        delegate?.addDeficienciCount(deficencyCount + 1)
        print("Click Event Count",deficencyCount + 1)
        removeAnimate()

        
    }
    
 // Dismiss Animation View On SuperView
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
// MARK:- Back Navigation Tapped
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
        
        self.appDelegate.window?.makeToast("Please wait...", duration:kToastDuration, position:CSToastPositionCenter)

        let poppedVC = navigationController?.popViewController(animated: true)
        print(poppedVC as Any)
        
        print("Back Button Tapped......")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK:- Set UIView Border Colors
extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        border.superlayer?.cornerRadius = 15
        self.layer.addSublayer(border)
    }
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    func addTopBorderWithClr(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
}
}
