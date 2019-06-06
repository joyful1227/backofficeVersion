//
//  Order.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Order: Cargo {
    
    var isarrived :Bool
    var userID : Int
    init(cargoID : Int,name: String, price: Int, image: UIImage,userID : Int, size : Size) {
        
        self.userID = userID
        self.isarrived = true
        super.init(cargoID: cargoID, name: name, price: price, image: image, size : size)
    }
}
