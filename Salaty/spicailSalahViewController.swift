//
//  spicailSalahViewController.swift
//  Salaty
//
//  Created by ahmed on 9/12/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit

class spicailSalahViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var selected : IndexPath?
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rakaaCell", for: indexPath) as! rakaaCell
        cell.contentView.frame.origin.x = -cell.frame.size.width
        UIView.animate(withDuration: 0.5, delay: TimeInterval(0.25 * Double(indexPath.row)), options: UIViewAnimationOptions.curveEaseInOut, animations: {
            cell.contentView.frame.origin.x = 0
            
            
            
            
        }, completion: nil)
        cell.rakaNAme.text = "rak3a"
        cell.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if selected?.row != nil {
                let cell2 = collectionView.cellForItem(at: selected!) as! rakaaCell
                cell2.indecator.isHidden = true
                
                
            }
            
            let cell = collectionView.cellForItem(at: indexPath) as! rakaaCell
            
            cell.indecator.isHidden = false
            selected = indexPath
        
        
    }
}
