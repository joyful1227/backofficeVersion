//
//  Product.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit
import Foundation

class Product: Codable {
    
    var product_id: Int?
    var product_name: String?
    var product_image: String?
    var size: String?
    var price: Int?
    var category_id: Int?
    var category_name : String?
    var product_status : Int?
//圖片2、廣告圖
//    var product_image2: String?
//    var banner_image: String?
    

    
//    public init(_ product_id: Int, _ product_name: String, _ product_image: String, _ size: String , _ price: Int, _ category_id: Int, _ category_name: String,_ product_status:Int) {
//        self.product_id = product_id
//        self.product_name = product_name
//        self.product_image = product_image
//        self.size = size
//        self.price = price
//        self.category_id = category_id
//        self.category_name = category_name
//        self.product_status = product_status
////        self.product_image2 = product_image2
////        self.banner_image = banner_image
//    }
    
    
    public init(_ product_id: Int, _ product_name: String, _ product_image: String, _ price: Int, _ category_id: Int, _ product_status: Int) {
        self.product_id = product_id
        self.product_name = product_name
        self.product_image = product_image
        self.price = price
        self.category_id = category_id
        self.product_status = product_status
        //        self.product_image2 = product_image2
        //        self.banner_image = banner_image
    }
    
    public init(_ product_id: Int, _ product_name: String, _ product_image: String, _ price: Int, _ category_id: Int, _ category_name: String , _ product_status: Int) {
        self.product_id = product_id
        self.product_name = product_name
        self.product_image = product_image
        self.price = price
        self.category_id = category_id
        self.category_name = category_name
        self.product_status = product_status
        //        self.product_image2 = product_image2
        //        self.banner_image = banner_image
    }
    
}
