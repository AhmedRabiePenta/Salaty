//
//  designableView.swift
//  Salaty
//
//  Created by ahmed on 10/4/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import UIKit

 @IBDesignable class designableView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    

}
