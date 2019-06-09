//
//  Ordermain.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/9.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit


class Ordermain: Codable {
    
    var order_id: Int?
    var orderaccount_id: Int?
    var totalcount: Int?
    var totalprice: Int?
    var receiver: String?
    var address: String?
    var phone: String?
    var costpoint: Int?
    var order_status: Int?    // 0=待出貨  1=已出貨  2=已送達  3=取消  4=已退貨
    
    init(order_id: Int, orderaccount_id: Int, totalcount: Int, totalprice: Int, receiver: String, address: String, phone: String, costpoint: Int, order_status: Int) {
        
        self.order_id = order_id
        self.orderaccount_id = orderaccount_id
        self.totalcount = totalcount
        self.totalprice = totalprice
        self.receiver = receiver
        self.address = address
        self.phone = phone
        self.costpoint = costpoint
        self.order_status = order_status
    }
    
    
    
    
    init(orderaccount_id : Int, totalcount : Int, totalprice : Int,receiver : String, address : String, phone : String,costpoint :Int,order_status : Int) {
        
        self.orderaccount_id = orderaccount_id
        self.totalcount = totalcount
        self.totalprice = totalprice
        self.receiver = receiver
        self.address = address
        self.phone = phone
        self.costpoint = costpoint
        self.order_status = order_status
    }
}
