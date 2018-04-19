//
//  LogOutViewController.swift
//  InSpectionPro
//
//  Created by Mac OS on 06/12/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit



class LogOutViewController: UIViewController {
    
    var delegate: navigationBarButtonDelegate?

    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var bottomConstraintLayout: NSLayoutConstraint!
    @IBOutlet var viewControllerHeight: UIView!
    
    var appVersion          : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
// Show PopupView For Prasent ViewController
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        // Do any additional setup after loading the view.
        
     
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    //    self.navigationController?.navigationBar.isHidden = true

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        

    }
// MARK:- Dismiss Animation For Superview
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
    
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        
        UserDefaults.standard.setValue("false", forKey: kIsFirstTime)
        UserDefaults.standard.synchronize()
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = viewController
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
   //    if let delegate = self.delegate {
        delegate?.dissmisLogOutView()
     
    //    }
        removeAnimate()

    }
    
    @IBAction func logOutButtonTapped(_ sender:UIButton) {

        
        
        
    }
    @IBAction func refreshButtonTapped(_ sender:UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
