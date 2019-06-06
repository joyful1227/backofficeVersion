//
//  Mylike.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit
import Foundation


class Mylike:Codable{
    
    var user_id: Int?
    var product_id: Int?
    var product_image: String?
    
    public init(_ user_id : Int,_ product_id:Int ){
        self.user_id = user_id
        self.product_id = product_id
    }
    
    
}
