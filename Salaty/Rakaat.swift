//
//  Rakaat.swift
//  Salaty
//
//  Created by ahmed on 9/12/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import Foundation
class Rakaat : NSObject {
    var title : String!
    var rakaaDetails : [RakaaDetails]!
    init(title : String, rakaaDetails : [RakaaDetails] ) {
        self.title = title
        self.rakaaDetails = rakaaDetails
    }
    
}
