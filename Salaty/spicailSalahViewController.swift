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
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var salahDetailsContainer: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var rakaaImageColor = [UIImage(named: "raka_color")!, UIImage(named: "tashud_color")!]
    var rakaaImageBlack = [UIImage(named: "raka_black")!, UIImage(named: "left_tashud_black")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        helper.rightAndTopshadow(view: container)
        helper.rightAndTopshadow(view: salahDetailsContainer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
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
        cell.background.image = self.rakaaImageBlack[0]

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
