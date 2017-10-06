//
//  homepageViewController.swift
//  Salaty
//
//  Created by ahmed on 9/11/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit
import CoreLocation
import UIColor_Hex_Swift

class HomePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var countryLabel: UILabel!
    var flag = 0
    var rakaDetailsArr : [RakaaDetails] = [RakaaDetails]()
    var salawatArr : [salawaatModel] = [salawaatModel]()
    var rakaatArr : [Rakaat] = [Rakaat]()
    var selectedCountry : String?
    var salahArr = [salah]()
    var location : CLLocation? = nil
    var selectedScrollSalah : IndexPath?
    var selectedRakaIndex: IndexPath?
//    var backgroundColor = [UIColor("#0B151B").cgColor, UIColor("#71261F").cgColor, UIColor("#FFCC00").cgColor, UIColor("#261315").cgColor, UIColor("#1D1D21").cgColor]
    var salahImage = [UIImage(named: "card_bg_elfagr")!, UIImage(named: "card_bg_eldoher")!, UIImage(named: "card_bg_elasr")!, UIImage(named: "card_bg_elmagrb")!, UIImage(named: "card_bg_elhasha")!]
    var rakaaImageColor = [UIImage(named: "raka_color")!, UIImage(named: "tashud_color")!]
    var rakaaImageBlack = [UIImage(named: "raka_black")!, UIImage(named: "left_tashud_black")!]
    struct salah {
        var salahName :String!
        var salahTime : String!
        init(salahName :String , salahTime :String) {
            self.salahName = salahName
            self.salahTime = salahTime
        }
    }
    var selectedSalah = 0
    var selectedraka = 1
    var selected : IndexPath?
    @IBOutlet weak var rakaaCollectionView: UICollectionView!
    @IBOutlet weak var mazhabCollectionView: UICollectionView!
    @IBOutlet weak var backgroundContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        initView()
       
        if helper.getToken(Key: "country") != nil {
        selectedCountry = helper.getToken(Key: "country")
            countryLabel.text = selectedCountry
        }
       
    
        if location == nil && selectedCountry == nil {

            let controller:popupVCViewController = self.storyboard!.instantiateViewController(withIdentifier: "go") as! popupVCViewController
            
        
            controller.view.frame = self.view.bounds;
            controller.willMove(toParentViewController: self)
            self.view.addSubview(controller.view)
            self.addChildViewController(controller)
            controller.didMove(toParentViewController: self)
            flag = 1
        }
        if location != nil{
        fetchCountryAndCity(location: location!, completion: { (country, city) in
            self.countryLabel.text = country
        })
        }
        readJson()
        collectionView.reloadData()
        rakaaCollectionView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        helper.shadow(view: backgroundContainer)

    }
    override func viewWillAppear(_ animated: Bool) {
        
        if helper.getToken(Key: "country") != nil{
            countryLabel.text = helper.getToken(Key: "country")
        }
    }
    func initView(){
    
        let nibName = UINib(nibName: "salahTimeCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "salahTimeCell")


        collectionView.dataSource = self
        collectionView.delegate = self
        rakaaCollectionView.dataSource = self
        rakaaCollectionView.delegate = self
        mazhabCollectionView.dataSource = self
        mazhabCollectionView.delegate = self
        }
    func showAlert(controller : UIViewController , message : String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "تخطي", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "اذهب لتغير البلد", style: UIAlertActionStyle.default, handler:{ (action: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ContryTableViewController") as? ContryTableViewController
            
            self.navigationController?.pushViewController(vc!, animated: true)
            //self.present(vc!, animated: true, completion: nil)
            
        }))
        controller.present(alert, animated: true, completion: nil)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            return salawatArr.count
        }
        else if collectionView == self.mazhabCollectionView {
            
                return salawatArr[selectedSalah].rakaat[selectedraka].rakaaDetails.count
        
        }
        else{
           
                return  salawatArr[selectedSalah].rakaat.count
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "salahTimeCell", for: indexPath) as! salahTimeCell
         
                cell.background.image = salahImage[indexPath.row]
            
                cell.salahName.text = salawatArr[indexPath.row].title
                cell.salahTime.text = salawatArr[indexPath.row].Time
            

            return cell
        }
        else if collectionView == self.rakaaCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rakaaCell", for: indexPath) as! rakaaCell
            cell.contentView.frame.origin.x = -cell.frame.size.width
            UIView.animate(withDuration: 0.5, delay: TimeInterval(0.25 * Double(indexPath.row)), options: UIViewAnimationOptions.curveEaseInOut, animations: {
                cell.contentView.frame.origin.x = 0
            }, completion: nil)
          
            
            cell.rakaNAme.text = salawatArr[selectedSalah].rakaat[indexPath.row].title
                
                cell.indecator.isHidden = true
            if salawatArr[selectedSalah].rakaat[indexPath.row].title.contains("ر"){
                cell.background.image =  rakaaImageBlack[0]
            }else {
                cell.background.image =  rakaaImageBlack[1]
            }
                
                if selected == nil && indexPath.row == 0{
                    cell.indecator.isHidden = false
                    selected = indexPath
                }
            
         
            return cell
        }
        else {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mazhabCell", for: indexPath) as! MazhbCollectionViewCell
            
           cell.mazhabName.text = salawatArr[selectedSalah].rakaat[selectedraka].rakaaDetails[indexPath.row].title
            cell.mazhabDetails.text = salawatArr[selectedSalah].rakaat[selectedraka].rakaaDetails[indexPath.row].details
            
            return cell

        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            selected = nil

                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            selectedSalah = indexPath.row
            self.collectionView.reloadData()
            rakaaCollectionView.reloadData()
            
        }else if collectionView == self.rakaaCollectionView{
            if selected != nil {
               let cell2 = rakaaCollectionView.cellForItem(at: selected!) as! rakaaCell
                cell2.indecator.isHidden = true
            }
            
            let cell = rakaaCollectionView.cellForItem(at: indexPath) as! rakaaCell

            cell.indecator.isHidden = false
                selected = indexPath
            mazhabCollectionView.reloadData()
            
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: self.view.frame.size.width/2.0, height: 180)
        }
        else if collectionView == self.mazhabCollectionView
        {
        return CGSize(width: self.view.frame.size.width, height: 75)
        }
        else{
            return CGSize(width: 48, height: 70)
        }
       
    }
    
    func readJson() {
        
        if let file = Bundle.main.path(forResource: "salawat", ofType: "json") {
            let data = NSData(contentsOfFile: file)!
            
            let allEntries : NSDictionary = try! JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! NSDictionary
            
           
            print(allEntries["data"] ?? " ")
            let salawat : [Any] = allEntries["data"] as! [Any]
            for salah in salawat {
                rakaatArr = [Rakaat]()
                let salahobj : [String : Any] = salah as! [String : Any]
                let salahTitle = salahobj["title"] as! String
                let salahTime = salahobj["time"] as! String
                let rakaat = salahobj["rakaat"] as! [Any]
                for raka in rakaat {
                    rakaDetailsArr = [RakaaDetails]()
                    let rakaObject = raka as! [String : Any]
                    let rakaTitle = rakaObject["title"] as! String
                    
                      let rakaDetails = rakaObject["details"] as! [Any]
                    for rakaDetailsObject in rakaDetails{
                    let rakaDetailsObjectDic = rakaDetailsObject as! [String : String]
                        let rakaDetailsTitle = rakaDetailsObjectDic["title"]
                        let rakaDetailstext = rakaDetailsObjectDic["details"]
                        rakaDetailsArr.append(RakaaDetails.init(title: rakaDetailsTitle!, details: rakaDetailstext))
            
                    }
                    
                    rakaatArr.append(Rakaat.init(title: rakaTitle, rakaaDetails: rakaDetailsArr))
                }
               salawatArr.append(salawaatModel.init(title: salahTitle, Time: salahTime, rakaat: rakaatArr))
                
            }
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                completion(country, city)
            }
        }
    }
    

}
