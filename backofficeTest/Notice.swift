//
//  Notice.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Notice : Cargo {
    
    var ismessage : Bool
    var content : String!
//    var userID : Int!
    
    
    init(content : String, cargo:Cargo) {
        self.ismessage = true
        self.content = content
        super.init(cargoID: cargo.cargoID, name: cargo.name, price: cargo.price, image: cargo.image!)
    }
    
    init(cargo:Cargo) {
        self.ismessage = false
        super.init(cargoID: cargo.cargoID, name: cargo.name, price: cargo.price, image: cargo.image!)
    }
    
    //    init(cargoID: Int , name: String, price: Int, image: UIImage, size : Size,title : String) {
    //        super.init(cargoID: cargoID, name: name, price: price, image: image, size : size)
    //    }
}
