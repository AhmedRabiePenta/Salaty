//
//  popupVCViewController.swift
//  Salaty
//
//  Created by ahmed on 10/4/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit

class popupVCViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var countryChange: UIButton!
    @IBAction func countryChange(_ sender: Any) {
        
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContryTableViewController") as? ContryTableViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
  
    @IBAction func skip(_ sender: Any) {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    override func viewDidLayoutSubviews() {
        bgImage.layer.cornerRadius = 10
        bgImage.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
