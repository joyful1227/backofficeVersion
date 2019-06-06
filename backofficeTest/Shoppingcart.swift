//
//  Shoppingcart.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Shoppingcart{
    
    var name: String!
    var price: Int!
    var image: UIImage!
    var amount: Int!
    
    init(_ name: String,_  price: Int,_  image: UIImage,_ amount: Int) {
        self.name = name
        self.price = price
        self.image = image
        self.amount = amount
    }
}
