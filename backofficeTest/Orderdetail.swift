//
//  Orderdetail.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/9.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Orderdetail:Codable{
    
    var order_id : Int?
    var orderproduct_id : Int?
    var amount : Int?
    var price : Int?
    var product_Name: String?
    var product_IMG:String?
    var size: String?
    
    init(order_id : Int,orderproduct_id : Int, amount : Int, price : Int) {
        self.order_id = order_id
        self.orderproduct_id = orderproduct_id
        self.amount = amount
        self.price = price
    }
    
    init(orderproduct_id : Int, amount : Int, price : Int) {
        self.orderproduct_id = orderproduct_id
        self.amount = amount
        self.price = price
    }
    
    init(order_id : Int, orderproduct_id : Int, amount : Int, price : Int, product_Name: String, product_IMG: String, size: String) {
        self.order_id = order_id
        self.orderproduct_id = orderproduct_id
        self.amount = amount
        self.price = price
        self.product_Name = product_Name
        self.product_IMG = product_IMG
        self.size = size
    }
}
