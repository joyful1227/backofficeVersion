//
//  Order.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Order: Codable {
    
    
    var cargoID: Int
    var name: String
    var price: Int
    var image: String
    var size: String
    var isarrived :Bool
    var userID : Int
    
    init(cargoID : Int,name: String, price: Int, image: String,userID : Int, size : String) {
        self.cargoID = cargoID
        self.name = name
        self.price = price
        self.image = image
        self.userID = userID
        self.isarrived = true
        self.size = size
        
        //super.init(cargoID: cargoID, name: name, price: price, image: image, size : size)
    }
}
