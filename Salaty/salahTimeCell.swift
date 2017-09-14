//
//  salahTimeCell.swift
//  Salaty
//
//  Created by ahmed on 9/11/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit

class salahTimeCell: UICollectionViewCell {

    @IBOutlet weak var salahTime: UILabel!
    @IBOutlet weak var salahName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func isTransparent(state : Bool){
        if state {
                self.contentView.alpha = 0.1
        }else{
            self.contentView.alpha = 1
        }
        
    }

}
