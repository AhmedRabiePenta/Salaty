//
//  File.swift
//  Salaty
//
//  Created by ahmed on 9/12/17.
//  Copyright © 2017 ahmedRabie. All rights reserved.
//

import Foundation
class salawaatModel : NSObject {
    var title : String!
    var Time : String!
    var rakaat : [Rakaat]!
    init(title : String, Time : String, rakaat : [Rakaat]) {
        self.title = title
        self.Time = Time
        self.rakaat = rakaat
    }

}
