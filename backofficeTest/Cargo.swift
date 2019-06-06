//
//  Cargo.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

class Cargo {
    var cargoID: Int
    var name: String!
    var price: Int!
    var image: UIImage!
    var size: Size!
    
    init(cargoID : Int,name: String, price: Int, image: UIImage) {
        self.name = name
        self.price = price
        self.image = image
        self.cargoID = cargoID
    }
    
    
    init(cargoID : Int,name: String, price: Int, image: UIImage ,size: Size) {
        self.name = name
        self.price = price
        self.image = image
        self.cargoID = cargoID
        self.size = size
    }
    
    //簡易建構式
    convenience init(){
        self.init(cargoID : 1,name: "商品名稱", price: 0, image: UIImage(named: "test")!,size : .S)
    }
}
