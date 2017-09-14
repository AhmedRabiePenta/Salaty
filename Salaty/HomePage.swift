//
//  homepageViewController.swift
//  Salaty
//
//  Created by ahmed on 9/11/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit
import CoreLocation
class HomePage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var countryLabel: UILabel!
    var flag = 0
    var rakaDetailsArr : [RakaaDetails] = [RakaaDetails]()
    var salawatArr : [salawaatModel] = [salawaatModel]()
    var rakaatArr : [Rakaat] = [Rakaat]()
    var selectedCountry : String?
    var salahArr = [salah]()
    var location : CLLocation? = nil
    struct salah {
        var salahName :String!
        var salahTime : String!
        init(salahName :String , salahTime :String) {
            self.salahName = salahName
            self.salahTime = salahTime
        }
    }
    var selectedSalah = 1
    var selectedraka = 1
    var selected : IndexPath?
    @IBOutlet weak var rakaaCollectionView: UICollectionView!
    @IBOutlet weak var mazhabCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        initView()
       
        if helper.getToken(Key: "country") != nil {
        selectedCountry = helper.getToken(Key: "country")
            countryLabel.text = selectedCountry
        }
       
        // Do any additional setup after loading the view.
        if location == nil && selectedCountry == nil {
            showAlert(controller: self, message: "لم نتمكن من  معرفه موقعك لتحديد مواعيد الصلاه")
            flag = 1
        }
        readJson()
        collectionView.reloadData()
        rakaaCollectionView.reloadData()
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
        
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        rakaaCollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)


    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            return salawatArr.count + 2
        }
        else if collectionView == self.mazhabCollectionView {
            return salawatArr[selectedSalah - 1].rakaat[selectedraka].rakaaDetails.count
        }
        else{
        return salawatArr[selectedSalah - 1].rakaat.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "salahTimeCell", for: indexPath) as! salahTimeCell
            if indexPath.row == 0 || indexPath.row == 6 {
                cell.salahName.isHidden = true
                cell.salahTime.isHidden = true
            }
            else {
                if selectedSalah != indexPath.row{
                cell.contentView.alpha = 0.1
                }
                else{
                cell.contentView.alpha = 1
                }
                cell.salahName.isHidden = false
                cell.salahTime.isHidden = false
                cell.salahName.text = salawatArr[indexPath.row - 1].title
                cell.salahTime.text = salawatArr[indexPath.row - 1].Time
            }
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

            return cell
        }
        else if collectionView == self.rakaaCollectionView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rakaaCell", for: indexPath) as! rakaaCell
            cell.contentView.frame.origin.x = -cell.frame.size.width
            UIView.animate(withDuration: 0.5, delay: TimeInterval(0.25 * Double(indexPath.row)), options: UIViewAnimationOptions.curveEaseInOut, animations: {
                cell.contentView.frame.origin.x = 0
            }, completion: nil)
            if selectedSalah != 0 {
            cell.rakaNAme.text = salawatArr[selectedSalah - 1].rakaat[indexPath.row].title
                cell.indecator.isHidden = true
            cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
            return cell
        }
        else {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mazhabCell", for: indexPath) as! MazhbCollectionViewCell
            if selectedSalah != 0 {
           cell.mazhabName.text = salawatArr[selectedSalah - 1].rakaat[selectedraka].rakaaDetails[indexPath.row].title
            cell.mazhabDetails.text = salawatArr[selectedSalah - 1].rakaat[selectedraka].rakaaDetails[indexPath.row].details
            }
            return cell

        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint)!
        selectedSalah = visibleIndexPath.row
        collectionView.reloadData()
        rakaaCollectionView.reloadData()
        mazhabCollectionView.reloadData()
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
            if indexPath.row != 0 || indexPath.row != 6{
            selectedSalah = indexPath.row
            self.collectionView.reloadData()
            
            rakaaCollectionView.reloadData()
            selected = nil
            }
        }else if collectionView == self.rakaaCollectionView{
            if selected?.row != nil {
            let cell2 = rakaaCollectionView.cellForItem(at: selected!) as! rakaaCell
                cell2.indecator.isHidden = true


            }
            
            let cell = rakaaCollectionView.cellForItem(at: indexPath) as! rakaaCell

            cell.indecator.isHidden = false
                selected = indexPath
            selectedraka = indexPath.row
            mazhabCollectionView.reloadData()
            
        }
    
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: self.view.frame.size.width/3.0, height: 77)
        }
        else if collectionView == self.mazhabCollectionView
        {
        return CGSize(width: 403, height: 85)
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
    
    

}
