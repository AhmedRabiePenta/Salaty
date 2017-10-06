//
//  MenueViewController.swift
//  Salaty
//
//  Created by ahmed on 9/12/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit

class MenueViewController: UIViewController {
    @IBOutlet weak var aboutUs: UIView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var feastSAlah: UIView!
    @IBOutlet weak var countrySelect: UIView!
    
    @IBOutlet weak var shareAboutCountainar: UIView!
    @IBOutlet weak var spicailSalahContainer: UIView!
    let selectedCountry : String! = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(MenueViewController.aboutUs(_:)))
        self.aboutUs.addGestureRecognizer(gesture)
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(MenueViewController.feast(_:)))
        self.feastSAlah.addGestureRecognizer(gesture3)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(MenueViewController.countrySelect(_:)))
        self.countrySelect.addGestureRecognizer(gesture2)
        // Do any additional setup after loading the view.
        if helper.getToken(Key: "country") != nil{
        countryName.text = helper.getToken(Key: "country")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
 
        if helper.getToken(Key: "country") != nil{
            countryName.text = helper.getToken(Key: "country")
        }
    }
    override func viewDidLayoutSubviews() {
        helper.rightAndTopshadow(view: countrySelect)
        helper.rightAndTopshadow(view: shareAboutCountainar)
        helper.rightAndTopshadow(view: spicailSalahContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func aboutUs(_ sender:UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "aboutus") as? AboutUsViewController
     
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func countrySelect(_ sender:UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContryTableViewController") as? ContryTableViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func feast(_ sender:UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "spicailSalahViewController") as? spicailSalahViewController
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


