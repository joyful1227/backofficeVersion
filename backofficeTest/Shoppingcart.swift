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
    
    var product_id:Int!
    var name: String!
    var price: Int!
    var image: String!
    var size : String!
    var amount: Int!
    
    init(product_id: Int, name: String, price: Int, image: String!, size: String, amout: Int) {
        self.product_id = product_id
        self.name = name
        self.price = price
        self.image = image
        self.size = size
        self.amount = amout
    }
}
